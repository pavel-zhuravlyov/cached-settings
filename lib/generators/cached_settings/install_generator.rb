# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/base'
require 'rails/generators/migration'

module CachedSettings
  class InstallGenerator < ::Rails::Generators::Base
    include Rails::Generators::Migration

    def self.next_migration_number(path)
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def copy_templates
      path = Rails::VERSION::MAJOR == 5 ? '../templates' : '../templates_old'
      InstallGenerator.source_root File.expand_path(path, __FILE__)

      migration_template 'create_cached_settings.rb', 'db/migrate/create_cached_settings.rb'
      template 'cached_setting.rb', 'app/models/cached_setting.rb'
    end
  end
end
