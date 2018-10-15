require 'rubocop/rake_task'
require 'pty'

# Add additional test suite definitions to the default test task here
namespace :test do
  desc 'Runs RuboCop on specified directories'
  RuboCop::RakeTask.new(:rubocop) do |task|
    # Dirs: app, lib, test
    task.patterns = ['app/**/*.rb', 'lib/**/*.rb', 'test/**/*.rb']

    # Make it easier to disable cops.
    task.options << '--display-cop-names'

    # Run extra Rails cops
    task.options << '--rails'

    # Abort on failures (fix your code first)
    task.fail_on_error = false
  end

  desc 'Crawl'
  task crawl: :environment do
    if ENV['PORT']
      system("rawler 127.0.0.1:#{ENV['PORT']} --local --wait 0 --ignore-fragments")
    else
      system('rawler developer.dev --local --wait 0 --ignore-fragments')
    end

    exit $CHILD_STATUS.exitstatus unless $CHILD_STATUS.exitstatus.zero?
  end

  desc 'Run all tests'
  task all: :environment do
    Rake::Task['test:rubocop'].invoke
    Rake::Task['spec'].invoke
    Rake::Task['test:crawl'].invoke
  end
end
