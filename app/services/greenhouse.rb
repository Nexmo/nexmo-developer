class Greenhouse
  DEPARTMENT_ID = 4019731002

  def self.careers
    new.jobs
  end

  def initialize
    @client = GreenhouseIo::JobBoard.new
  end

  def jobs
    @jobs ||= Rails.cache.fetch('careers') do
      fetch_jobs.map { |j| Career.new(j) }
    end
  end

  def fetch_jobs
    @client.jobs(content: 'true')[:jobs].select do |j|
      j[:departments].any? { |d| d[:id] == DEPARTMENT_ID }
    end
  end
end
