class RemoveColumnPlaceholder < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :placeholder
  end
end
