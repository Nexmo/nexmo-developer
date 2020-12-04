require 'bundler'
require 'rspec/core/rake_task'
Bundler::GemHelper.install_tasks

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rspec_opts = '--format documentation --colour --backtrace'
end

task :default => [:spec]
