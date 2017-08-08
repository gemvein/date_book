# frozen_string_literal: true

class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end
