source 'http://rubygems.org'

gem 'rails', '~> 3.2.13'
gem 'rack', '~> 1.4.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', '0.3.11'
gem 'turbo-sprockets-rails3'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  # Add Foundation Here
  gem 'compass-rails' # you need this or you get an err
  gem 'turbo-sprockets-rails3'
end
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

gem 'jquery-rails', '2.2.1'
gem 'devise', '3.0.1'
group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
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
group :development do
  gem 'debugger'
  gem 'meta_request'
end
# This version needs to be hardcoded for OpenShift compatibility
gem 'thor', '= 0.14.6'
gem 'strong_parameters', "0.2.1"

# This needs to be installed so we can run Rails console on OpenShift directly
gem 'minitest'
gem 'kaminari'
