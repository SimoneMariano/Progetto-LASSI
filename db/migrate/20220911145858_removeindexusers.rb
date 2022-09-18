class Removeindexusers < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, :name => :index_users_on_email
    add_index :users, :email, unique: false
    #Ex:- add_index("admin_users", "username")
  end
end
