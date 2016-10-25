# frozen_string_literal: true

require 'cached_settings/version'
require 'cached_settings/config'
require 'cached_settings/storage'

module CachedSettings
  def self.get(key, default: nil)
    Storage.get(key, default)
  end

  def self.set(key, value)
    Storage.set(key, value)
  end

  def self.create(key, value)
    Storage.create(key, value)
  end
end
