# frozen_string_literal: true
$:.push File.expand_path('../lib', __FILE__)

require 'cached_settings/version'

Gem::Specification.new do |s|
  s.name        = 'cached_settings'
  s.version     = CachedSettings::VERSION
  s.authors     = ['pavel-zhuravlyov']
  s.summary     = 'CachedSettings'

  s.add_dependency 'rails'
  s.add_dependency 'redis'
  s.add_dependency 'redis-rails'

  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'mock_redis'
  s.add_development_dependency 'standalone_migrations'
  s.add_development_dependency 'factory_girl'
end
