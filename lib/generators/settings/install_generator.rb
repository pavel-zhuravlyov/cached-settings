# frozen_string_literal: true

require 'rails/generators/base'
require 'rails/generators/migration'

module Settings
  class InstallGenerator < ::Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def self.next_migration_number(path)
      Time.now.utc.strftime('%Y%m%d%H%M%S')
    end

    def copy_templates
      migration_template 'create_settings.rb', 'db/migrate/create_settings.rb'
      template 'setting.rb', 'app/models/setting.rb'
    end
  end
end
