class ChangeCoursesDistanceToFloat < ActiveRecord::Migration[6.1]
  def up
    change_column :courses, :distance, :float
    change_column :courses, :route, :integer, default: 0
  end
  
  def down
    change_column :courses, :distance, :integer, default: 0
    change_column :courses, :route, :float, default: 0
  end
end
