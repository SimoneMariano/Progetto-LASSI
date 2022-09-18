class AddIndexToCoursesUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :courses_users, [:course_id,:user_id], unique: true
    remove_index :courses_users, name: :index_courses_users_on_course_id

  end
end
