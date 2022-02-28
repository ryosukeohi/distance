class CreateCourseImages < ActiveRecord::Migration[5.2]
  def change
    create_table :course_images do |t|
      t.integer :course_id, null: false
      t.integer :image_id, null: false

      t.timestamps null: false
    end
  end
end
