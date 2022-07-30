class Changecolumncategory < ActiveRecord::Migration[7.0]
  def change
    change_column :categories, :name, :string, unique: true
  end
end
