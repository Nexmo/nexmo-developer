require 'pty'

# Add additional test suite definitions to the default test task here
namespace :test do
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
