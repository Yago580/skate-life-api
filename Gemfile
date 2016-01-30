source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5'
gem 'rails-api'
gem 'pg'
gem 'puma'
gem 'rack-timeout'

group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'byebug'
  gem 'bullet'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'bundler-audit', require: false
end

group :production do
  gem 'rails_12factor'
end

# Look into using this
# To use Jbuilder templates for JSON
# gem 'jbuilder'
# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
