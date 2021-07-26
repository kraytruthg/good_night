# frozen_string_literal: true

class CreateUsersAndSleeps < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :sleeps do |t|
      t.references :user, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.timestamps
    end
  end
end
