# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Run analysis tools to ensure code quality'
task :code_analysis do
  sh 'bundle exec rubocop lib spec'
  sh 'bundle exec reek lib'
end
