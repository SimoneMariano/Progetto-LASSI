class AddStartDateToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :startDate, :datetime
  end
end
