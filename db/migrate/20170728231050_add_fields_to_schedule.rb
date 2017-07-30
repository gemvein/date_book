class AddFieldsToSchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :duration, :integer
    add_column :schedules, :all_day, :boolean
  end
end
