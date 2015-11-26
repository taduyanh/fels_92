class Word < ActiveRecord::Base
  self.per_page = 100
  belongs_to :category

  has_many :answers
  has_many :lesson_words
  has_many :users, through: :lesson_words
  
  BY_USER_QUERY = "id in 
    (SELECT word_id from lesson_words 
      where user_id = :user_id 
      and correct = :correct)" 
  
  scope :learn, ->(user_id){where(BY_USER_QUERY, user_id: user_id, correct: true)}
  scope :not_learn, ->(user_id){where.not(BY_USER_QUERY, user_id: user_id, correct: true)}
  scope :by_category, ->(category_id){where(category_id: category_id) if category_id}
end
