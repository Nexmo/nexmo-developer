begin
  # First check if algolia config is set as an env variable. If so, use it.
  # Otherwise try to load algolia.yml from the config directory.
  if ENV['ALGOLIA_CONFIG']
    ALGOLIA_CONFIG = YAML.safe_load(ENV['ALGOLIA_CONFIG'])
  else
    ALGOLIA_CONFIG = YAML.load_file("#{Rails.root}/config/algolia.yml")
  end
rescue Errno::ENOENT
  Rails.logger.info('No Algolia config found. Search is now disabled')
end

if defined?(ALGOLIA_CONFIG) && ENV['ALGOLIA_SEARCH_KEY']
  filters = ALGOLIA_CONFIG.flat_map do |_, config|
    next unless config && config['filters']

    config['filters'].flat_map do |facet, values|
      values.map { |value| "#{facet}: #{value}" }
    end
  end

  algolia_search_parameters = {
    filters: filters.compact.join(' AND NOT ').prepend('NOT '),
    attributesToSnippet: ['body', 'body_safe'],
  }

  ALGOLIA_SECURED_SEARCH_KEY = Algolia.generate_secured_api_key(ENV['ALGOLIA_SEARCH_KEY'], algolia_search_parameters)

  Algolia.init(application_id: ENV['ALGOLIA_APPLICATION_ID'], api_key: ALGOLIA_SECURED_SEARCH_KEY)
end
