class AddColumnDescription < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :description, :string, :null => false
  end
end
