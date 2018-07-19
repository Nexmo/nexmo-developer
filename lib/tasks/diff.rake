namespace :diff do
  desc 'Rebuild all .repos and raise PR'
  task 'always': :environment do
    Rake::Task['repos:pull'].invoke
      time = Time.new.to_i
      branch = "code-example-update-#{time}"
      puts "Checking out new branch - #{branch}".colorize(:yellow)
      system "git checkout -b #{branch}"
      puts 'Adding repo files'.colorize(:yellow)
      system 'git add .repos'
      puts 'Commiting changes'.colorize(:yellow)
      system "git commit -m 'Automated: Updating code examples'"
      puts 'Pushing'.colorize(:yellow)
      system "git push git@github.com:Nexmo/nexmo-developer.git #{branch}"

      body =  "Auto-generated PR, via diff:always"

      puts "Notifying Nexmo Developer of branch - #{branch}".colorize(:yellow)
      RestClient.post ENV['OPEN_PULL_REQUEST_ENDPOINT'], {
        'branch' => branch,
        'body' => body,
        'secret' => ENV['CI_SECRET'],
      }.to_json, {
        content_type: :json,
        accept: :json,
      }
  end

  desc 'Build files for comparison'
  task 'execute': :environment do
    puts 'Building base'.colorize(:yellow)
    Rake::Task['diff:build:base'].invoke

    puts 'Updating repos'.colorize(:yellow)
    Rake::Task['repos:pull'].invoke

    puts 'Building comparison'.colorize(:yellow)
    Rake::Task['diff:build:compare'].invoke
    puts 'Comparing'.colorize(:yellow)

    Rake::Task['diff:compare:pr'].invoke
  end

  desc 'Build files for comparison'
  task 'build:base': :environment do
    Diff.generate(mode: 'base')
  end

  desc 'Build files for comparison'
  task 'build:compare': :environment do
    Diff.generate(mode: 'compare')
  end

  desc 'Build files for comparison'
  task 'compare:cli': :environment do
    diff = Diff.new
    diff.diff(:color)
    diff.report_cli
  end

  desc 'Build files for comparison'
  task 'compare:pr': :environment do
    diff = Diff.new
    diff.diff(:text)
    diff.report_pull_request
  end
end
