# frozen_string_literal: true

module CachedSettings
  class Config
    attr_accessor :redis_instance, :cache_expiration

    def initialize
      @redis_instance = nil
      @cache_expiration = 3600
    end
  end

  def self.configure_storage
    Storage.config ||= Config.new
    yield Storage.config
  end
end
