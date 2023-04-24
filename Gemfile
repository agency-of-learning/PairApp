source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'annotate'
gem 'image_processing', '~> 1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'omniauth-auth0', '~> 3.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0' # prevents forged authentication requests
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'redis', '~> 4.0'
gem 'sassc-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
