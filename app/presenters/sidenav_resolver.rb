class SidenavResolver
  IGNORED_PATHS = ['..', '.', '.DS_Store'].freeze

  def initialize(path:, language:, namespace: nil)
    @path      = path
    @language  = language
    @namespace = namespace
  end

  def items
    if @path.starts_with?('app/views')
      directories(@path)[:children]
    else
      directories("#{@path}/#{I18n.default_locale}")[:children]
    end
  end

  def directories(path, name = nil)
    data = { title: (name || path), path: path }
    data[:children] = []
    # Find all markdown files on disk that are children
    Dir.foreach(path) do |entry|
      next if entry.start_with?('.')
      next if IGNORED_PATHS.include? entry

      full_path = File.join(path, entry)
      if File.directory?(full_path)
        config = if tabbed_folder?(full_path)
                   YAML.safe_load(File.read("#{full_path}/.config.yml"))
                 end

        if config && config['tabbed']
          data[:children] << { title: config['title'], path: full_path, is_tabbed?: true }
        else
          data[:children] << directories(full_path, entry)
        end
      else
        doc_path = Nexmo::Markdown::DocFinder.find(root: @path, document: full_path, language: @language, strip_root_and_language: true).path
        data[:children] << { title: entry, path: doc_path, is_file?: true }
      end
    end

    # Do we have tasks for this product?
    product = path.sub(%r{#{Rails.configuration.docs_base_path}/\w+\/\w+\/}, '')
    if DocumentationConstraint.products_for_routes.include? product
      tasks = TutorialList.by_product(product)

      # If we have use cases and tutorials, output them
      if tasks['tutorials'].any?
        data[:children] << { title: 'tutorials', path: "/#{product}/tutorials", children: tasks['tutorials'] }
      end

      if tasks['use_cases'].any?
        # Otherwise show use_case as the top level
        data[:children] << { title: 'use-cases', path: "/#{product}/use-cases", children: tasks['use_cases'] }
      end
    end

    sort_navigation(data)
  end

  def sort_navigation(context)
    # Sort top level
    context[:children].sort_by! do |item|
      configuration_identifier = url_to_configuration_identifier(path_to_url(item[:path]))
      options = configuration_identifier.split('.').inject(Navigation::OVERRIDES) { |h, k| h[k] || {} }

      sort_array = []
      sort_array << (options['navigation_weight'] || 1000) # If we have a path specific navigation weight, use that to explicitly order this
      sort_array << (item[:is_file?] ? 0 : 1) if context[:path].include? 'code-snippets' # Directories *always* go after single files for Code Snippets (priority 1 rather than 0). This even overrides config entries
      sort_array << item_navigation_weight(item) # If we have a config entry for this, use it. Otherwise put it at the end
      sort_array << (item[:is_file?] ? 0 : 1) # If it's a file it gets higher priority than a directory
      sort_array << navigation_weight_from_meta(item) # Use the config entry if we have it. Otherwise it goes to the end
      sort_array
    end

    # Sort children if needed
    context[:children].each do |child|
      sort_navigation(child) if child[:children]
    end

    context
  end

  def url_to_configuration_identifier(url)
    url.tr('/', '.')
  end

  def strip_namespace(path)
    path = path.gsub('.yml', '').sub("#{Rails.configuration.docs_base_path}/_use_cases/", 'use-cases/')
    path = path.gsub('.yml', '').sub('config/tutorials/', '/tutorials/')
    path = path.gsub('.yml', '').sub("#{Rails.configuration.docs_base_path}/", '')
    path.sub(%r{\w+\/\w+\/}, '')
  end

  def path_to_url(path)
    strip_namespace(path).gsub('.md', '')
  end

  def item_navigation_weight(item)
    key = navigation_key(item)
    Navigation::WEIGHT[key] || 1000
  end

  def navigation_weight_from_meta(item)
    return 1000 unless item[:is_file?]

    document_meta(item)['navigation_weight'] || 1000
  end

  def document_meta(item)
    doc = Nexmo::Markdown::DocFinder.find(root: item[:root] || @path, document: item[:path], language: @language, strip_root_and_language: true).path
    YAML.load_file(doc)
  end

  private

  def tabbed_folder?(full_path)
    File.exist?("#{full_path}/.config.yml")
  end

  def navigation_key(item)
    if item[:is_file?]
      item[:title].split('.').first
    else
      item[:title]
    end
  end
end
