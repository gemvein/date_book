# frozen_string_literal: true

# This migration comes from date_book (originally 20170807133845)
class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :css_class
    end
    add_index :calendars, :slug, unique: true
  end
end
