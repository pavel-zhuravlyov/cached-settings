# frozen_string_literal: true

module Settings
  class << self
    attr_accessor :config
  end

  class Config
    attr_accessor :redis_instance

    def initialize
      @redis_instance = nil
    end
  end

  def self.configure
    self.config ||= Config.new
    yield config
  end
end
