# frozen_string_literal: true

class CachedSetting < ActiveRecord::Base
  validates :key, :value, presence: true
  validates :key, uniqueness: true
end
