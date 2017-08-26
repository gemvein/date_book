# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'juwelier'
Juwelier::Tasks.new do |gem|
  gem.name = 'date_book'
  gem.homepage = 'http://www.gemvein.com/museum/cases/date_book'
  gem.license = 'MIT'
  gem.summary = 'Rails 5 Engine to give users their own calendars of events.'
  gem.email = 'karen.e.lundgren@gmail.com'
  gem.authors = ['Karen Lundgren']
  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

load 'lib/tasks/date_book.rake'
task default: :spec
