# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.string :key, default: nil, null: false
      t.string :value, default: nil, null: false
      t.index :key, unique: true
    end
  end
end
