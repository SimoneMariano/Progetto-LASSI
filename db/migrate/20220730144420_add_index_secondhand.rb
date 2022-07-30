class AddIndexSecondhand < ActiveRecord::Migration[7.0]
  def change
    add_index :secondhands, [:book_id,:user_id], unique: true
  end
end
