#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rubocop/rake_task'
require File.expand_path('../config/application', __FILE__)

task default: :rubocop

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end

Coaster::Application.load_tasks
