require 'rspec/core/rake_task'
require "bundler/gem_tasks"

task :default => :spec
desc "Run all spec tests"
RSpec::Core::RakeTask.new do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end
