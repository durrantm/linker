source 'http://rubygems.org'

gem 'rails', '3.0.10'

group :development, :test do
  gem 'mysql2', '~> 0.2.11'
end

group :production do
  gem "pg" # Used for Production.
end

gem "acts_as_list"
gem "simple_form"
#gem "calendar_date_select"
gem "haml"
gem 'calendar_date_select', :git => 'http://github.com/paneq/calendar_date_select.git' #, :branch => 'rails3test'

# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  # gem 'webrat'  
  # not able to get webrat working yet. mdd 6/1/2012
  # Ah, but capybara does work, and that's the other option for the ui testing, so that's great!
  gem 'capybara'
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails", "~> 3.0"
end
