# frozen_string_literal: true
require 'spec_helper'
require 'generators/cached_settings/templates/cached_setting'

describe CachedSettings do
  before do
    CachedSettings.configure_storage do |config|
      config.redis_instance = MockRedis.new
    end
  end

  it 'has a version number' do
    expect(CachedSettings::VERSION).not_to be nil
  end

  it 'has a redis instance' do
    expect(CachedSettings::Storage.config.redis_instance).not_to be nil
  end
end
