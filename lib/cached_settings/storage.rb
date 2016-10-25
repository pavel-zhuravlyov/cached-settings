# frozen_string_literal: true

module CachedSettings
  class Storage
    class << self
      attr_accessor :config

      def get(key, default)
        key = key.to_s
        default = default.to_s if default
        cached(key) || extract(key, default)
      end

      def set(key, value)
        key = key.to_s
        value = value.to_s
        setting = CachedSetting.find_by(key: key) || raise("CachedSetting '#{key}' not found")
        setting.update!(value: value)
        redis.set("setting:#{key}", value, ex: config.cache_expiration)
      end

      def create(key, value)
        key = key.to_s
        value = value.to_s
        CachedSetting.create!(key: key, value: value)
        redis.set("setting:#{key}", value, ex: config.cache_expiration)
      end

    private

      def extract(key, default = nil)
        value = CachedSetting.find_by(key: key)&.value || default || raise("CachedSetting '#{key}' not found")
        redis.set("setting:#{key}", value, ex: config.cache_expiration)
        value
      end

      def cached(key)
        redis.get("setting:#{key}")
      end

      def redis
        raise 'CachedSettings: redis instance is not configured' if config.redis_instance.nil?
        config.redis_instance
      end
    end
  end
end
