class AddEndDateToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :endDate, :datetime
  end
end
