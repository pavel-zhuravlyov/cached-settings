# frozen_string_literal: true

require 'settings/version'
require 'settings/config'
require 'settings/storage'

module Settings
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
