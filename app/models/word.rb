class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers
  has_many :lessions_words
  has_many :users, through: :lessions_words
end
