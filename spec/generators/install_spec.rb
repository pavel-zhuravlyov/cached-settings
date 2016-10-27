# frozen_string_literal: true
require 'spec_helper'
require 'generators/cached_settings/install_generator'
require 'rails'

describe CachedSettings::InstallGenerator, type: :generator do
  before do
    Rails::Generators.invoke('cached_settings:install', ['-q'])
  end

  after do
    FileUtils.rm_rf('app')
    FileUtils.rm_rf('db')
  end

  let(:model_path) { 'app/models/cached_setting.rb' }
  let(:migration_matcher_result) { Dir['db/migrate/*.rb'].select { |f| f =~ /create_cached_settings/ } }

  it 'generates model and migration' do
    expect(File).to exist(model_path)
    expect(migration_matcher_result).not_to be_empty
  end
end
