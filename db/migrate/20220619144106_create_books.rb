class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :ISBN
      t.string :title
      t.string :placeholder
    
      t.timestamps
    end
  end
end
