# This migration comes from date_book (originally 20170728231142)
class CreateDateBookEventOccurrences < ActiveRecord::Migration[5.1]
  def self.up
    create_table :date_book_event_occurrences do |t|

      t.references :schedulable, polymorphic: true, index: { name: 'schedulable' }
      t.datetime :date

      t.timestamps
      
    end
  end

  def self.down
    drop_table :date_book_event_occurrences
  end
end