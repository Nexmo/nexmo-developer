require 'diffy'

class Repos

  def self.update()
      n = 'nexmo-community/nexmo-php-quickstart'
      repo = Repo.new({ namespace: n, repo: n })
      system "rm -rf #{repo.directory} 2>&1", out: File::NULL

      system "git clone --depth=1 #{repo.url} -b #{repo.branch} #{repo.directory} 2>&1", out: File::NULL
      system "rm -rf #{repo.directory}/.git 2>&1", out: File::NULL
  end

end
