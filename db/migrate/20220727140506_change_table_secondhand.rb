class ChangeTableSecondhand < ActiveRecord::Migration[7.0]
  def change
    add_index :secondhands, [:book,:user], unique: true
  end
end
