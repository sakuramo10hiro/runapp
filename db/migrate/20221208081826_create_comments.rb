class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment_content
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      
      t.timestamps
    end
  end
end
