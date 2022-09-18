class AddColumnApprovedToSecondhand < ActiveRecord::Migration[7.0]
  def change
    add_column :secondhands, :approved, :boolean, :default => false
 
  end
end
