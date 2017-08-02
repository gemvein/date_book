class CreateDateBookEventOccurrences < ActiveRecord::Migration[5.1]
  def self.up
    create_table :date_book_event_occurrences do |t|

      t.references :schedulable, polymorphic: true
      t.datetime :date

      t.timestamps
      
    end
  end

  def self.down
    drop_table :date_book_event_occurrences
  end
end