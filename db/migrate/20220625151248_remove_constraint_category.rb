class RemoveConstraintCategory < ActiveRecord::Migration[7.0]
  def change
    remove_index :categories, name: :index_books_categories_on_book_id
    remove_index :categories, name: :index_books_categories_on_category_id
    add_index :categories, [:name, :isCourse], :unique => true
  end
end
