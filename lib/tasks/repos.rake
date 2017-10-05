require 'colorize'

namespace :repos do
  desc 'Pull repos to local'
  task pull: :environment do

    ARGV.each { |a| task a.to_sym do ; end }

    repos = {}

    if ARGV[1]
      repos[ARGV[1]] = {
        'branch' => ARGV[2] || 'master',
        'github' => ARGV[1],
      }
    else
      repos = YAML.load_file("#{Rails.root}/config/repos.yml")
    end

    progressbar = ProgressBar.create(total: repos.count)

    warnings = []

    repos.each do |repo, config|
      if config['path']
        if File.directory?("#{Rails.root}/#{config['path']}")
          warnings << "A path has been used for #{repo}. This should be removed or commented out and rake repos:pull run again before committing"
        else
          puts "Path #{config['path']} provided for #{repo} but does not exist. Can not continue.".colorize(:light_red)
          exit 1
        end
      end
    end

    repos.each do |repo, config|

      system "rm -rf ./.repos/#{repo} 2>&1", out: File::NULL

      if config['path']
        system "ln -s #{Rails.root}/#{config['path']} #{Rails.root}/.repos/#{repo}"
      else
        repo_url = "git://github.com/#{config['github']}.git"
        system "git clone --depth=1 #{repo_url} -b #{config['branch']} ./.repos/#{repo} 2>&1", out: File::NULL
        system "rm -rf ./.repos/#{repo}/.git 2>&1", out: File::NULL
      end

      progressbar.increment
    end

    warnings.each { |warning| puts warning.colorize(:light_yellow) }
  end
end
