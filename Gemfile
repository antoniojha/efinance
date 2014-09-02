source 'https://rubygems.org'
# This gem is used for rss feed parsing


# Paperclip, used to upload pictures to Amazon S3
gem 'paperclip'

gem 'paperclip-compression'
# This provides standardized interface to access a variety of spreadsheet format
gem 'roo'


gem 'aws-sdk'
gem 'cocaine'
ruby '1.9.3'
# use for pagination
gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'faker'
gem 'figaro'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

#scheduler
gem 'rufus-scheduler'

# Install library to use Yellow Fade Technique to highlight ajax change
gem 'jquery-ui-rails'
#Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.1.2'

group :development,:test do
  # Use rpsec-rails for development testing

  gem 'rconsole', '~> 0.1.0'
  gem 'sqlite3'
  gem 'rspec-rails','2.13.1'
  gem 'guard-rspec','2.5.0'
  #Use thin as the server as mongrel is outdated with Ruby v1.9.3
  #gem 'thin'
  #Please add the following to your Gemfile to avoid polling for changes:
  require 'rbconfig'
  if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
    gem 'wdm', '>= 0.1.0'
  end
  # the following gems will speed up rspec testing
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
end
group :test do
  gem 'capybara'
  gem 'selenium-webdriver', '2.35.1'
end

# Used for CSS
gem 'bootstrap-sass'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

group :production do
  # refer to Michael Hurtl chapter 1.4.1 and 2
  gem 'pg'#PostgreSQL
  gem 'rails_12factor' #used by Heroku to serve static assets such as images and stylesheets.

end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'googlecharts'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
