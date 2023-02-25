class AddColumnsToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :address, :string
    add_column :courses, :latitude, :float
    add_column :courses, :longitude, :float
    add_column :courses, :route, :float, default: 0
  end
end
