class CreateRecordImages < ActiveRecord::Migration[5.2]
  def change
    create_table :record_images do |t|
      t.integer :record_id, null: false
      t.integer :image_id, null: false

      t.timestamps 
    end
  end
end
