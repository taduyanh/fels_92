class AddFinishColumnToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :finished, :boolean, default: false
  end
end
