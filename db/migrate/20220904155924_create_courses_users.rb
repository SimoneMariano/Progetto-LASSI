class CreateCoursesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :courses_users, id: false do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
