class CreateLessonWords < ActiveRecord::Migration
  def change
    create_table :lesson_words do |t|
    	t.integer :lesson_id
    	t.integer :word_id
    	t.boolean :correct
    	t.integer :user_id
      t.integer :answer_id
    	t.timestamps
    end
  end
end
