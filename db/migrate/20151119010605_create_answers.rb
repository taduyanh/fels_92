class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
    	t.string :text
    	t.integer :word_id
    	t.boolean :correct
    	t.timestamps
    end
  end
end
