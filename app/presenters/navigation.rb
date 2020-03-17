class Navigation
  IGNORED_PATHS = ['..', '.', '.DS_Store'].freeze
  NAVIGATION    = YAML.load_file("#{Rails.root}/config/navigation.yml")
  WEIGHT        = NAVIGATION['navigation_weight']
  OVERRIDES     = NAVIGATION['navigation_overrides']

  def initialize(folder)
    @folder = folder
  end

  def options
    @options ||= begin
      path_to_url.tr('/', '.').split('.').inject(OVERRIDES) { |h, k| h[k] || {} }
    end
  end

  def path_to_url
    @path_to_url ||= begin
      if @folder[:is_task?]
        path = @folder[:path].sub(@folder[:root], '')
        path.sub(%r{^/\w+\/}, '').chomp('.yml')
      else
        path = @folder[:path].gsub("#{Rails.configuration.docs_base_path}/", '')
        path.sub(%r{^\w+\/\w+\/}, '').chomp('.md')
      end
    end
  end

  def product
    @product ||= begin
                   if @folder[:path].starts_with?('app/views')
                     path_to_url.split('/').first
                   else
                     DocumentationConstraint.products_for_routes.find do |p|
                       path_to_url.starts_with? p
                     end
                   end
                 end
  end

  def document
    @document ||= path_to_url.sub("#{product}/", '')
  end
end
