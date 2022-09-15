class AddUniquematricola < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :matricola, unique: true
  end
end
