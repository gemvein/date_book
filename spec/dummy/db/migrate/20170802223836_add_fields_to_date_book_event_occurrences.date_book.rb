# This migration comes from date_book (originally 20170728231837)
class AddFieldsToDateBookEventOccurrences < ActiveRecord::Migration[5.1]
  def change
    add_column :date_book_event_occurrences, :end_date, :datetime
  end
end
