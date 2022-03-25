class DeleteDefaultIntroduction < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :introduction, :tex
  end
end
