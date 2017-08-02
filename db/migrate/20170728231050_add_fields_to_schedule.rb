class AddFieldsToSchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :duration, :integer, default: 3600
    add_column :schedules, :all_day, :boolean, default: false
  end
end
