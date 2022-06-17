class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.integer :ISBN, primary_key: true
      t.string :title
      t.integer :quantity

      t.timestamps
    end
  end
end
