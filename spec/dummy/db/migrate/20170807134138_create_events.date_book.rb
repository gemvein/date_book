# This migration comes from date_book (originally 20170807133846)
class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :calendar

      t.string :name
      t.string :slug, unique: true
      t.text :description
      t.string :css_class

      t.date :start_date
      t.time :start_time

      t.integer :duration
      t.boolean :all_day

      t.timestamps
    end
  end
end
