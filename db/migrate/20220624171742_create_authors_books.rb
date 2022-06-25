class CreateAuthorsBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :authors_books, id: false do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :author, null: false, foreign_key: true
      t.timestamps
    end
  end
end
