class AddIndexNullUser < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, false   
    change_column_null :users, :matricola, false 
  end
end
