class Addindexuser < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :email, unique: "false"
    #Ex:- add_index("admin_users", "username")
  end
end
