class Follower < ActiveRecord::Base
  belongs_to :from_user, class_name: "User", foreign_key: "from_id"
  belongs_to :to_user, class_name: "User", foreign_key: "to_id"
end
