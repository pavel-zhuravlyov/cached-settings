# frozen_string_literal: true

module Settings
  class Storage
    class << self
      def redis
        raise 'cache storage is not configured' if parent.config.redis_instance.nil?
        parent.config.redis_instance
      end

      def get(key, default)
        key = key.to_s
        default = default.to_s if default
        cached(key) || extract(key, default)
      end

      def set(key, value)
        key = key.to_s
        value = value.to_s
        setting = Setting.find_by(key: key) || raise("Setting '#{key}' not found")
        setting.update!(value: value)
        redis.set("setting:#{key}", value, ex: ENV['SETTINGS_CACHE_EXP'])
      end

      def create(key, value)
        key = key.to_s
        value = value.to_s
        Setting.create!(key: key, value: value)
        redis.set("setting:#{key}", value, ex: ENV['SETTINGS_CACHE_EXP'])
      end

    private

      def extract(key, default = nil)
        value = Setting.find_by(key: key)&.value || default || raise("Setting '#{key}' not found")
        redis.set("setting:#{key}", value, ex: ENV['SETTINGS_CACHE_EXP'])
        value
      end

      def cached(key)
        redis.get("setting:#{key}")
      end
    end
  end
end
