class CreateLessionsWords < ActiveRecord::Migration
  def change
    create_table :lessions_words do |t|
    	t.integer :lession_id
    	t.integer :word_id
    	t.boolean :is_correct
    	t.integer :user_id
    	t.timestamps
    end
  end
end
