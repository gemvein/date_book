class AddFieldsToDateBookEventOccurrences < ActiveRecord::Migration[5.1]
  def change
    add_column :date_book_event_occurrences, :end_date, :datetime
  end
end
