class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :ISBN, null: false, unique: true
      t.string :title, null: false
      t.string :placeholder, null: false

      t.timestamps
    end
  end
end
