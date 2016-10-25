# frozen_string_literal: true

require 'test_app/db/migrate/create_cached_settings'

RSpec.configure do |config|
  DATABASE_PATH = 'spec/test_app/db/test.db'

  config.before do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: DATABASE_PATH)
    ActiveRecord::Migration.verbose = false
    CreateCachedSettings.migrate :up
  end

  config.after do
    CreateCachedSettings.migrate :down
    FileUtils.rm_f(DATABASE_PATH)
  end
end
