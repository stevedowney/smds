source 'https://rubygems.org'

# gem 'active_record_query_trace'
gem 'devise'
gem 'haml'
gem 'jquery-rails'
gem "nilify_blanks"
gem 'rails', '3.2.6'
gem 'simple_form'
gem 'thin'

gem 'pg'
# gem 'mysql2'


# you would think these should be in assets group,
# but Heroku doesn't like it
gem 'jquery-ui-rails'
gem 'twitter-bootstrap-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'rack-mini-profiler'
	gem 'rails-footnotes' # http://stackoverflow.com/a/11619954
end

group :test do
	gem 'factory_girl_rails', :require => false
end

group :test, :development do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'poltergeist'
  gem "rspec-rails", "~> 2.0"
  gem 'simplecov', :require => false
  gem 'spork-rails'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
