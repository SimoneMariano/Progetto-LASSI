class Removemail < ActiveRecord::Migration[7.0]
  def change
    remove_index :usres, name: :index_users_on_email_and_provider
    remove_column :users, :email
  end
end
