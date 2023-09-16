source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "rails", "~> 7.0.2", ">= 7.0.2.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
gem "rspec-rails"
gem "factory_bot_rails"
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'rails-i18n'
gem 'dotenv'
gem 'pry-rails'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end


gem "dockerfile-rails", ">= 1.5", :group => :development
