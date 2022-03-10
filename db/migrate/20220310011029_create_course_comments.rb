class CreateCourseComments < ActiveRecord::Migration[5.2]
  def change
    create_table :course_comments do |t|
      t.text :comment, null: false
      t.integer :user_id, null: false
      t.integer :course_id, null: false

      t.timestamps null: false
    end
  end
end
