source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.4.1"
gem "rails", "~> 5.2.0"
# gem "bootstrap-sass"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "bcrypt"
gem "config"
gem "jquery-rails"
gem "kaminari"
gem "faker"
gem "figaro"
gem "carrierwave"
gem "mini_magick"
gem "bootstrap-kaminari-views"
gem "bootstrap", "~> 4.1.3"
gem "bootstrap4-kaminari-views"

group :development, :test do
  gem "sqlite3"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production do
  gem "pg"
  gem "fog"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
