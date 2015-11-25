class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'training@'
  TEMP_EMAIL_REGEX = /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  has_many :passive_follows, class_name: "Follower", foreign_key: "to_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :from_user

  has_many :active_follows, class_name: "Follower", foreign_key: "from_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :to_user

  has_many :lessions

  has_many :lessions_words
  has_many :words, through: :lessions_words

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable

  validates_format_of :email, without: TEMP_EMAIL_REGEX, on: :update
  scope :exclude, ->(user){ where.not(id: user.id) }

  def self.find_for_oauth auth, signed_in_resource = nil

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth auth

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email &&
        (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.find_by_email email if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def follow other_user
    active_follows.create to_id: other_user.id
  end

  def unfollow other_user
    active_follows.find_by(to_id: other_user.id).destroy
  end


  def following? user
    self.following.include? user
  end

  def followed_by? user
    self.followers.include? user
  end

end
