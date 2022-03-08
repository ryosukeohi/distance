class AddAddressToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :address, :string, null: false
  end
end
