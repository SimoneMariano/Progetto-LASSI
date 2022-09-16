class Addnonulli < ActiveRecord::Migration[7.0]
  def change
    change_column :seats, :name, :string, :null => false
    add_index :seats, :name, unique: true
    change_column :seats, :available, :boolean, :null => false
    change_column :seats, :available, :boolean, :default => true
    drop_table :view_reservations


  end
end
