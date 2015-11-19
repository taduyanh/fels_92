class LessionsWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :lession
end
