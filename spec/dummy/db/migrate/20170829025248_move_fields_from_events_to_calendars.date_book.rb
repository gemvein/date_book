class MoveFieldsFromEventsToCalendars < ActiveRecord::Migration[5.1]
  def change

    add_column :calendars, :text_color, :string, default: '#ffffff'
    add_column :calendars, :background_color, :string, default: '#3a87ad'
    add_column :calendars, :border_color, :string, default: '#235371'

    remove_column :events, :text_color
    remove_column :events, :background_color
    remove_column :events, :border_color

  end
end
