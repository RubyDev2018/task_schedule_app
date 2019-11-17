class RenameImageNameColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :image_name, :image
  end
end
