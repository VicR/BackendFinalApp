source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Kaminari
gem 'kaminari'
# Active Model Serializers
gem 'active_model_serializers', '~> 0.10.0'
# Acts as State Machine
gem 'aasm'
# Carrierwave file uploader
gem 'carrierwave', '~> 1.0'
# Base64 support for carrierwave
gem 'carrierwave-base64', '= 2.5.0'
# Devise Token Auth
gem 'devise_token_auth'
# FOG AWS integration
gem 'fog-aws'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'rack-cors'
gem 'sentry-raven'
gem 'health_check'
# MiniMagick interface for imagemagick
gem 'mini_magick'
# one signal
gem 'one_signal'
# dot environment
gem 'dotenv-rails'

group :test do
  gem 'capybara'
  gem 'faker', '~> 1.8.7'
  gem 'poltergeist'
  gem 'simplecov', require: false
  # use timecop for manipulating time tests
  gem 'timecop', '~> 0.8.1'
  # VCR for remote API mocks
  gem 'vcr', '~> 3.0.3'
  # enable mocks within context examples
  gem 'webmock'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.6.0'
end

group :development do
  gem 'brakeman', require: false
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'guard'
  gem 'guard-bundler', require: false
  gem 'guard-migrate'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'guard-yard'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'yard'
end
