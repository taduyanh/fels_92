class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers
  has_many :lesson_words
  has_many :users, through: :lesson_words
end
