class ChangeDatetypeImageIdOfRecordImage < ActiveRecord::Migration[5.2]
  def change
    change_column :record_images, :image_id, :string
  end
end
