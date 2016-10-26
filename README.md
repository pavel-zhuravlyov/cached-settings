# Cached Settings

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cached_settings', github: 'Railsreactor/cached-settings'
```

And then execute:

    $ bundle
    
## Post Installation

Install migrations: 

    $ rails g cached_settings:install
    $ rake db:migrate

## Setup

Set redis instance for caching.
For example:

```ruby
CachedSettings.configure_storage do |config|
  config.redis_instance = Redis.current
end
```
## Usage

```ruby
CachedSettings.create('key', 'value') # create a key-value pair setting
CachedSettings.set('key', 'value') # update a key-value pair setting
CachedSettings.get('key') # return setting value by key
CachedSettings.get('key', default_value) # return default_value if setting is not found
```
