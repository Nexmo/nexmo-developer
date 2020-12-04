class Greenhouse
  DEPARTMENT_ID = 4019731002
  TITLES = ['sdk', 'advocate', 'community manager', 'education', 'dashboard', 'documentation'].freeze

  def self.devrel_careers
    new.devrel_positions
  end

  def self.careers
    new.jobs
  end

  def self.offices
    new.offices
  end

  def self.expire_cache
    Rails.cache.delete('careers')
    Rails.cache.delete('offices')
  end

  def initialize
    @client = GreenhouseIo::JobBoard.new
  end

  def devrel_positions
    @devrel_positions ||= jobs.select(&:devrel?)
  end

  def jobs
    @jobs ||= Rails.cache.fetch('careers', expires_in: 1.hour) do
      fetch_jobs.map { |j| Career.new(j) }
    end
  end

  def offices
    @offices ||= Rails.cache.fetch('offices', expires_in: 5.hours) do
      @client.offices[:offices]
    end
  end

  def fetch_jobs
    @client.jobs(content: 'true')[:jobs]
  end
end
