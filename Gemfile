source 'https://rubygems.org'

gem 'rails', '3.2.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem "pg" # Used for Production for heroku.
  #gem 'mysql2'
end

gem 'american_date'
gem 'jquery-rails'
gem "acts_as_list"
gem "simple_form"
gem "haml"

group :development, :test do
  gem 'mysql2'
  gem 'capybara'
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails", "~> 3.0"
  gem "shoulda-matchers"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
