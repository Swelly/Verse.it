source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.13'
gem 'twitter'

gem 'jquery-rails'
gem 'newrelic_rpm' # Installing New_Relic as a gem
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter', :github => 'arunagw/omniauth-twitter'
gem 'dotenv-rails'

gem 'pg', :group => :production
gem 'puma', :group => :production
gem 'twitter'
gem 'tweetstream'
# gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'pry-rails'           # Causes rails console to open pry
                            # https://github.com/rweng/pry-rails
  gem 'pry-debugger'        # Adds step, next, finish, and continue commands and breakpoints
                            # https://github.com/nixme/pry-debugger
  gem 'pry-stack_explorer'  # Navigate the call-stack
                            # https://github.com/pry/pry-stack_explorer
  gem 'annotate'            # Annotate all your models, tests, fixtures, and factories
                            # https://github.com/ctran/annotate_models
  gem 'quiet_assets'        # Turns off the Rails asset pipeline log
                            # https://github.com/evrone/quiet_assets
  # gem 'better_errors'       # Replaces the standard Rails error page with a much better and more useful error page
                            # https://github.com/charliesome/better_errors
  gem 'binding_of_caller'   # Advanced features for better_errors advanced features (REPL, local/instance variable inspection, pretty stack frame names)
                            # https://github.com/banister/binding_of_caller
  gem 'meta_request'        # Supporting gem for Rails Panel (Google Chrome extension for Rails development).
                            # https://github.com/dejan/rails_panel/tree/master/meta_request
  gem 'rails-erd'           # Diagrams your models. NOTE! $ brew install graphviz
                            # https://github.com/voormedia/rails-erd
  gem 'rspec-rails', '~> 2.0' # Rspec-rails is a testing framework for Rails 3.x and 4.x.
  gem 'dotenv-rails'
end
