REDIRECTS = YAML.load_file("#{Rails.root}/config/redirects.yml")
ENVIRONMENT_REDIRECTS = YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || '')

class Redirector
  def self.find(request)
    find_by_config(request) || find_by_environment_redirect(request) # rubocop:disable Rails/DynamicFindBy
  end

  def self.find_by_config(request)
    REDIRECTS[request.path] || false
  end

  def self.find_by_environment_redirect(request)
    return false unless ENVIRONMENT_REDIRECTS
    ENVIRONMENT_REDIRECTS.each do |path, new_url|
      return new_url if Regexp.new(path).match(request.path)
    end

    false
  end
end
