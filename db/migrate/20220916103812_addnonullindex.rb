class Addnonullindex < ActiveRecord::Migration[7.0]
  def change
    change_column :reservations, :startDate, :datetime, :null => false
    change_column :reservations, :endDate, :datetime, :null => false
    change_column :reservations, :date, :date, :null => false



    #Ex:- add_index("admin_users", "username")
  end
end
