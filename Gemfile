source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'faker', '1.4.2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rails_autolink'
gem 'ransack'
gem 'kaminari'
gem 'sidekiq'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'rmagick'
gem "bootstrap4-datetime-picker-rails"
gem 'momentjs-rails'
# カレンダー専用gem
gem 'fullcalendar-rails'
gem 'momentjs-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 4.11'
  gem 'pry-rails'  # rails console(もしくは、rails c)でirbの代わりにpryを使われる
  gem 'pry-doc'    # methodを表示
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
  gem 'pry-stack_explorer' # スタックをたどれる
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  #gem 'chromedriver-helper'
  gem 'rspec-rails', '~> 3.7'
  gem 'webdrivers', '~> 4.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'slim-rails'
gem 'html2slim'
gem 'bootstrap', '~> 4.1.1'
