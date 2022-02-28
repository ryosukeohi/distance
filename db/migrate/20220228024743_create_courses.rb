class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.float :distance, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps null: false
    end
  end
end
