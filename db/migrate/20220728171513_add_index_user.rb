class AddIndexUser < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :matricola, unique: true
    add_index :users, :email, unique: true

  end
end
