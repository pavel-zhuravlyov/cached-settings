# frozen_string_literal: true

class CachedSetting < ApplicationRecord
  validates :key, :value, presence: true
  validates :key, uniqueness: true
end
