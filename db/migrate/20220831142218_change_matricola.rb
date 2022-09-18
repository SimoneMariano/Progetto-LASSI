class ChangeMatricola < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :matricola, :integer, null: true
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
