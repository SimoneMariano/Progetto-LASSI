class CreateBooksUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :books_users, id: false do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
