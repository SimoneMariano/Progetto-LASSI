class AddCalendarIdToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :calendar_id, :string
  end
end
