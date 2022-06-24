class CreateBooksCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :books_categories, id: false do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
