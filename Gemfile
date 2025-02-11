source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Rack::Cors provides support for Cross-Origin Resource Sharing (CORS) for Rack compatible web applications.
gem 'rack-cors'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use to create tokens with high security and security, avoiding theft between different systems
gem 'jwt'
# Brings convention over configuration to your JSON generation.
gem 'active_model_serializers'
# Use pagination
gem 'kaminari-activerecord'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Create fake data
gem 'ffaker'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Create object for Uni-test
  gem 'factory_bot_rails'
  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  gem 'pry-byebug'
  # Brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default testing framework
  gem 'rspec-rails'
  # RuboCop is a Ruby static code analyzer and code formatter
  gem 'rubocop'
  # Performance optimization analysis for your projects
  gem 'rubocop-performance', require: false
  # Helps you write more understandable, maintainable Rails-specific tests under Minitest.
  gem 'shoulda'
  # Provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that, if written by hand, would be much longer, more complex, and error-prone.
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
