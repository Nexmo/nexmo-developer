class Greenhouse
  DEPARTMENT_ID = 4019731002
  TITLES = ['sdk', 'advocate', 'community manager', 'education', 'dashboard', 'documentation'].freeze

  def self.careers
    new.jobs
  end

  def self.expire_cache
    Rails.cache.delete('careers')
  end

  def initialize
    @client = GreenhouseIo::JobBoard.new
  end

  def jobs
    @jobs ||= Rails.cache.fetch('careers', expires_in: 1.hour) do
      fetch_jobs.map { |j| Career.new(j) }
    end
  end

  def fetch_jobs
    @client.jobs(content: 'true')[:jobs].select do |j|
      valid_job?(j)
    end
  end

  def valid_job?(job)
    job[:departments].any? { |d| d[:id] == DEPARTMENT_ID } &&
      job[:title].downcase.match?(Regexp.union(TITLES))
  end
end
