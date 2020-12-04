CORE_REDIRECTS = LoadConfig.load_file('config/redirects.yml') || {}
STITCH_REDIRECTS = LoadConfig.load_file('config/stitch-redirects.yml') || {}

REDIRECTS = CORE_REDIRECTS.merge(STITCH_REDIRECTS)

ENVIRONMENT_REDIRECTS = YAML.safe_load(ENV['ENVIRONMENT_REDIRECTS'] || '')

class Redirector
  def self.find(request)
    url = find_by_config(request) || find_by_environment_redirect(request) # rubocop:disable Rails/DynamicFindBy
    return unless url

    url
  end

  def self.find_by_config(request)
    REDIRECTS[strip_locale_from_path(request.path)] || false
  end

  def self.find_by_environment_redirect(request)
    return false unless ENVIRONMENT_REDIRECTS

    ENVIRONMENT_REDIRECTS.each do |path, new_url|
      return new_url if Regexp.new(path).match(strip_locale_from_path(request.path))
    end

    false
  end

  def self.strip_locale_from_path(path)
    path.sub("/#{I18n.locale}", '')
  end
end
