class DropCoursesUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :courses_users
    add_column :users, :course_id, :integer, :foreign_key => true, :null => true
  end
end
