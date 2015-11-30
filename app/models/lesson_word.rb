class LessonWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :lesson

  scope :correct_words, ->{where(correct: true)}
  belongs_to :answer

  def update_result
    self.update_attribute :correct, answer.correct if answer
  end
end
