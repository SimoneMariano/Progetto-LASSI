class CreateBookRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :book_rentals do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :start
      t.datetime :end



      t.timestamps
    end

    add_index :book_rentals, [:book, :user], unique: true
  end
end
