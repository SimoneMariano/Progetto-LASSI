class RemoveConstraintCat < ActiveRecord::Migration[7.0]
  def change
    remove_index :categories, name: :index_categories_on_name_and_isCategory
  end
end
