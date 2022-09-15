class RemovedatetimeFromreservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :datetime
  end
end
