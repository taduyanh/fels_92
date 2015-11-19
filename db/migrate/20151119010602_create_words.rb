class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
    	t.string :text_ja
    	t.string :text_vn
    	t.integer :category_id
    	t.timestamps
    end
  end
end
