class RemuveConstraintCategory < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :name
    add_column :categories, :name, :string, :unique => false
  end
end
