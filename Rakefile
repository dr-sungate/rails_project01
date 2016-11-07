# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

begin
  require 'ci/reporter/rake/test_unit'
  require 'ci/reporter/rake/test_unit_loader.rb'
  task :testunit => ['ci:setup:testunit']
rescue LoadError
end

Rails.application.load_tasks
