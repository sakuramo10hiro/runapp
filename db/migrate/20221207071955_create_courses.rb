class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.text :course_description
      t.boolean :public
      t.text :course_image
      t.string :distance
      t.string :road_type
      t.string :toilet
      t.string :undulation
      t.string :signal

      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
