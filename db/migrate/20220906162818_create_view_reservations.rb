class CreateViewReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :view_reservations do |t|

      t.timestamps
    end
  end
end
