class AddAvailableToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :available, :boolean
  end
end
