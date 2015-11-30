class Lesson < ActiveRecord::Base
  has_many :words, through: :lesson_words
  has_many :lesson_words, dependent: :destroy
  accepts_nested_attributes_for :lesson_words
  belongs_to :user
  belongs_to :category
  QUESTION_LENGTH = 20
  after_create :import_words
  after_update :finish_lesson

  def import_words
    words_id = self.category.words.not_learn(self.user.id).pluck :id
    inserts = []
    question_length = [QUESTION_LENGTH, words_id.length].min
    self.transaction do 
      question_length.times do |time|
        LessonWord.create(
          word_id: words_id.delete_at(rand(words_id.length)), 
          lesson_id: self.id, 
          user_id: self.user_id
        )
      end
      self.update_attributes question_length: question_length
    end
  end

  def finish_lesson
    if self.finished?
      self.transaction do 
        self.lesson_words.each { |lesson_word| lesson_word.update_result }
      end
    end
  end
end
