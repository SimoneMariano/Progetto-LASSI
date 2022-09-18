class ChangeIndexSecondhand < ActiveRecord::Migration[7.0]
  def change
    remove_index :secondhand, name: :index_secondhands_on_book_and_user
  end
end
