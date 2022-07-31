class ChangeNameend < ActiveRecord::Migration[7.0]
  def change
    remove_column :book_rentals, :start
    remove_column :book_rentals, :end
    add_column :book_rentals, :startDate, :date, null: false
    add_column :book_rentals, :endDate, :date, null: false
    
  end
end
