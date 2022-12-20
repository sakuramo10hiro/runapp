class ChangeCoursesDistanceToInteger < ActiveRecord::Migration[6.1]
  def up
    change_column :courses, :distance, :integer, default: 0
    change_column :courses, :road_type, :integer, default: 0
    change_column :courses, :toilet, :integer, default: 0
    change_column :courses, :undulation, :integer, default: 0
    change_column :courses, :signal, :integer, default: 0
  end

  def down
    change_column :courses, :distance, :string
    change_column :courses, :road_type, :string
    change_column :courses, :toilet, :string
    change_column :courses, :undulation, :string
    change_column :courses, :signal, :string
  end
end
