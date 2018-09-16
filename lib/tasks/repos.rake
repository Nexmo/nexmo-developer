require 'colorize'
require 'ruby-progressbar'

namespace :repos do
  desc 'Pull repos to local'
  task pull: :environment do
    ARGV.each { |a| task a.to_sym }

    repos = []

    if ARGV[1]
      repo = Repo.new(branch: ARGV[2])
      if Repo.valid_url? ARGV[1]
        repo.url = ARGV[1]
      else
        repo.repo = ARGV[1]
      end
      repos << repo
    else
      repos = YAML.load_file("#{Rails.root}/config/repos.yml").map do |namespace, config|
        Repo.new({ namespace: namespace }.merge(config))
      end
    end

    progressbar = ProgressBar.create(total: repos.count)

    warnings = []

    repos.each do |r|
      if r.path
        if File.directory?("#{Rails.root}/#{r.path}")
          warnings << "A path has been used for #{r.namespace}. This should be removed or commented out and rake repos:pull run again before committing"
        else
          puts "Path #{r.path} provided for #{r.namespace} but does not exist. Can not continue.".colorize(:light_red)
          exit 1
        end
      end
    end

    repos.each do |r|
      system "rm -rf #{r.directory} 2>&1", out: File::NULL

      if r.path
        system "ln -s #{Rails.root}/#{r.path} #{r.directory}", out: File::NULL
      else
        system "git clone --depth=1 #{r.url} -b #{r.branch} #{r.directory} 2>&1", out: File::NULL
        system "rm -rf #{r.directory}/.git 2>&1", out: File::NULL
      end

      progressbar.increment
    end

    warnings.each { |warning| puts warning.colorize(:light_yellow) }
  end
end
