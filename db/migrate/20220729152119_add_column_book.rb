class AddColumnBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :stock, :integer, :null => false

  end
end
