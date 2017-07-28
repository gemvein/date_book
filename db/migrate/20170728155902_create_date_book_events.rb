class CreateDateBookEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :date_book_events do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
