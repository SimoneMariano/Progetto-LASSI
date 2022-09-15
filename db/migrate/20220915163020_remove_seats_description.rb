class RemoveSeatsDescription < ActiveRecord::Migration[7.0]
  def change
    remove_column :seats, :description
  end
end
