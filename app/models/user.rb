class User < ActiveRecord::Base
  has_many :followers, class_name: "Follower", foreign_key: "to_id"
  has_many :followers_users, through: :followers, source: :from_user

  has_many :following, class_name: "Follower", foreign_key: "from_id"
  has_many :following_users, through: :following, source: :to_user
  
  has_many :lessions

  has_many :lessions_words
  has_many :words, through: :lessions_words
end
