class AddCalenderEventToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start, :datetime, null: false
    add_column :tasks, :end, :datetime, null: false
    add_column :tasks, :all_day, :boolean, default: false, null: false
  end
end
