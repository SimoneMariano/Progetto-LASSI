class AddUniqueindex < ActiveRecord::Migration[7.0]
  def change
    add_index :authors, :name, unique: true
    add_index :courses, :name, unique: true

    #Ex:- add_index("admin_users", "username")
  end
end
