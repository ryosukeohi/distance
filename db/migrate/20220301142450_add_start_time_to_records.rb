class AddStartTimeToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :start_time, :datetime
  end
end
