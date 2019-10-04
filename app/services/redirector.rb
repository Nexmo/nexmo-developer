CORE_REDIRECTS = YAML.load_file("#{Rails.root}/config/redirects.yml") || {}
STITCH_REDIRECTS = YAML.load_file("#{Rails.root}/config/stitch-redirects.yml") || {}
AUTOMATED_REDIRECTS = YAML.load_file("#{Rails.root}/config/automatic-redirects.yml") || {}

REDIRECTS = CORE_REDIRECTS.merge(STITCH_REDIRECTS).merge(AUTOMATED_REDIRECTS)

ENVIRONMENT_REDIRECTS = YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || '')

class Redirector
  def self.find(request)
    url = find_by_config(request) || find_by_environment_redirect(request) # rubocop:disable Rails/DynamicFindBy
    Redirect.where(url: request.path).first_or_create.increment!('uses') if url # rubocop:disable Rails/SkipsModelValidations
    url
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
