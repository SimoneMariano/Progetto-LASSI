class CorrectIdBook < ActiveRecord::Migration[7.0]
  def change
    change_column :books, :id, :integer, :null => false, :default => 'active'
  end
end
