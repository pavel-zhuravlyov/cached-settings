# frozen_string_literal: true

$:.unshift File.expand_path('../../lib', __FILE__)

require 'cached_settings'
require 'active_record'
require 'mock_redis'
require 'factory_girl'
require 'fileutils'
require 'simplecov'

SimpleCov.start
FactoryGirl.find_definitions

Dir['./spec/support/**/*.rb'].each { |f| require f }
