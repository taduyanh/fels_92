class Lession < ActiveRecord::Base
  has_many :words
  belongs_to :user
  belongs_to :category
end
