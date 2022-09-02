class AddToBookRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :book_rentals, :calendar_id, :string, null: true, unique: true
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
