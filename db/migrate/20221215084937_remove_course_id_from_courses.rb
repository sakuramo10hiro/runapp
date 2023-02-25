class RemoveCourseIdFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :course_id, :integer
  end
end
