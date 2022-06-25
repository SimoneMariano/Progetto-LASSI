class RemoveColumnCategory < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :course
  end
end
