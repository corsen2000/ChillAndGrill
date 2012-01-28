source 'http://rubygems.org'

gem 'rails', '3.2.1'
# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'email_validator'
gem 'cancan'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  #gem 'thin'
  # To use debugger
  gem 'linecache19', '0.5.13', :path => "~/.rvm/gems/ruby-1.9.3-p0/gems/linecache19-0.5.13/"
  gem 'ruby-debug-base19', '0.11.26', :path => "~/.rvm/gems/ruby-1.9.3-p0/gems/ruby-debug-base19-0.11.26/"
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
