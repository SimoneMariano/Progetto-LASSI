class ChangeName < ActiveRecord::Migration[7.0]
  def change
    rename_table :favorites, :books_users
  end
end
