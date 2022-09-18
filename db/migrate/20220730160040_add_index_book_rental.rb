class AddIndexBookRental < ActiveRecord::Migration[7.0]
  def change
    remove_index :book_rentals, name: :index_book_rentals_on_book_and_user
    add_index :book_rentals, [:book_id, :user_id], unique: true
  end
end
