class LessonWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :lesson

  scope :correct_words, ->{where(correct: true)}
end
