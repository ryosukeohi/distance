class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :user_id, null: false
      t.text :description
      t.float :distance, null: false

      t.timestamps null: false
    end
  end
end