class Removecolumncategory < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :isCourse
  end
end
