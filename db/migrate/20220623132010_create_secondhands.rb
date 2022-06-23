class CreateSecondhands < ActiveRecord::Migration[7.0]
  def change
    create_table :secondhands do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
