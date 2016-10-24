$:.push File.expand_path("../lib", __FILE__)

require "settings/version"

Gem::Specification.new do |s|
  s.name        = "settings"
  s.version     = Settings::VERSION
  s.authors     = ["pavel-zhuravlyov"]
  s.summary     = "Summary of Settings."

  # s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

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
end
