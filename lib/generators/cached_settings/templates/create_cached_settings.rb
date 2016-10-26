# frozen_string_literal: true

class CreateCachedSettings < ActiveRecord::Migration
  def change
    create_table :cached_settings do |t|
      t.string :key, default: nil, null: false
      t.string :value, default: nil, null: false
      t.index :key, unique: true
    end
  end
end
