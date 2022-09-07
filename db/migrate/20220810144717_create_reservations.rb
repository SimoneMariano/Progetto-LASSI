class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|

      t.belongs_to :seat, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime  :datetime

      t.timestamps
    end
  end
end
