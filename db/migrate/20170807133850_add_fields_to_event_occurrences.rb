# frozen_string_literal: true

class AddFieldsToEventOccurrences < ActiveRecord::Migration[5.1]
  def change
    add_column :event_occurrences, :end_date, :datetime
  end
end
