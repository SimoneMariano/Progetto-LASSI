class Removeindexuser < ActiveRecord::Migration[7.0]
  def change
    remove_index :users, name: :index_users_on_email
    remove_index :users, name: :index_users_on_matricola


  end
end
