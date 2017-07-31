# frozen_string_literal: true

source 'https://rubygems.org'

# Our Ruby framework
gem 'rails', '>= 4', '< 6'

# Gotta have internationalization
gem 'rails-i18n', '>= 4', '< 6'

# Bootstrap Leather makes building websites in Bootstrap easier
gem 'bootstrap_leather', '>= 0.9', '< 1'

# Bootstrap Forms generates forms elegantly
gem 'bootstrap_form', '>= 2.7', '< 3'

# WYSIWYG fields, yay!
gem 'bootstrap-wysihtml5-rails'

# Jquery is our Javascript Framework
gem 'jquery-rails', '~> 4'

# Haml because I like it
gem 'haml-rails', '>= 1.0', '< 2'

# Jbuilder for easy building of json objects
gem 'jbuilder'

# Devise for Authentication
gem 'devise', '>= 4.3', '< 5'

# CanCanCan for Authorization
gem 'cancancan', '>= 2.0', '< 3'

# Rolify for Ownership
gem 'rolify', '>= 5.1', '< 6'

# Friendly Id for Clean URLs
gem 'friendly_id', '>= 5.2', '< 6'

# Ice Cube and Schedulable for recurrence and scheduling
gem 'ice_cube', '>= 0.16', '< 1'
gem 'schedulable', '>= 0.0.10', '< 1', git: 'git@github.com:nerakdon/schedulable.git', branch: 'working'

# Full Calendar to display what we've got
gem 'fullcalendar-rails', '>= 3.4', '< 4'
gem 'momentjs-rails', '>= 2.17', '< 3'

group :development do
  gem 'bundler', '~> 1.0'
  gem 'juwelier', '~> 2.4'
  # gem 'rspec', '>= 3.5', '< 4'
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'bootstrap-sass', '~> 3.3'
  gem 'byebug', '~> 9'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'faker', '~> 1.4'
  gem 'rspec-its', '>= 1'
  gem 'rspec-rails', '>= 3.5', '< 4'
  gem 'seedbank', '~> 0.3'
  gem 'sqlite3', '~> 1.3'
  gem 'high_voltage', '~> 3'
end

group :test do
  gem 'capybara', '~> 2.4'
  gem 'coveralls', '~> 0.8', require: false
  gem 'database_cleaner', '~> 1.4'
  gem 'launchy', '~> 2', require: false
  gem 'poltergeist', '~> 1.14'
  gem 'rails-controller-testing', '~> 1.0'
  gem 'rspec-collection_matchers', '>= 1'
  gem 'rspec-html-matchers', '~> 0.7'
  gem 'shoulda-matchers', '>= 2.8', '< 3.2'
end
