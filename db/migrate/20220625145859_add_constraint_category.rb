class AddConstraintCategory < ActiveRecord::Migration[7.0]
  def change
    add_index :categories, [:name,:isCategory], unique: true
  end
end
