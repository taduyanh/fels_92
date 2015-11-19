class Category < ActiveRecord::Base
  has_many :lessions
  has_many :words
end
