source 'https://rubygems.org'

ruby '2.0.0'

#gem 'rails', '3.2.17'
gem 'rails', '4.0.2'
gem 'httparty'

gem 'activeresource' # See if it's needed.  Maybe for json requests?

# Gems used only for assets and not required
# in production environments by default.
# group :assets do
# removed 'group :assets' for rails4
  gem 'sass-rails'#,   '~> 3.2.3'
  gem 'coffee-rails'#, '~> 3.2.1'
  gem 'uglifier'#, '>= 1.0.3'
#end

group :production do
  gem "pg" # Used for Production for heroku.
  gem 'rails_12factor' # Avoid deprecation warnings
end

# gem 'american_date' # trying without 8/17/2014
gem 'jquery-rails'
gem "acts_as_list"
gem "simple_form"
gem "haml"
gem 'local_time'

group :development, :test do
  gem 'mysql2'
  gem 'capybara'
  #gem "rspec-rails", "~> 2.0"
  gem "rspec-rails"
  gem "autotest-standalone"
  gem "factory_girl_rails", "~> 3.0"
  gem "shoulda-matchers"
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
