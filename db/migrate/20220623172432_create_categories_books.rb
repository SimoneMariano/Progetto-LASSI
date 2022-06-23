class CreateCategoriesBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :categories_books, id: false do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
