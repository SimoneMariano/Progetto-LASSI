class Addbulletind < ActiveRecord::Migration[7.0]
  def change
    change_column :bulletins, :title, :string, :null => false
    change_column :bulletins, :description, :string, :null => false
  end
end
