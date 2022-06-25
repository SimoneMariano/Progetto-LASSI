class AddColumnIsCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :isCourse, :boolean, :null => false
  end
end
