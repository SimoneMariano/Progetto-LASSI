class AddToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, :null => true
    add_column :users, :surname, :string, :null => true

  end
end
