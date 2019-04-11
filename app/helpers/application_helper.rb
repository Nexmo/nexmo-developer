IGNORED_PATHS = ['..', '.', '.DS_Store'].freeze
NAVIGATION = YAML.load_file("#{Rails.root}/config/navigation.yml")
NAVIGATION_WEIGHT = NAVIGATION['navigation_weight']
NAVIGATION_OVERRIDES = NAVIGATION['navigation_overrides']
COLLAPSIBLE = ['Messages API', 'Dispatch API', 'Messaging', 'SMS', 'Conversion API', 'SNS', 'US Short Codes', 'Voice', 'Number Insight', 'Account', 'Global', 'SIP', 'Voice API', 'Setup', 'In-App Voice', 'In-App Messaging'].freeze

# What tasks do we have available?
TASKS = {} # rubocop:disable Style/MutableConstant
TASK_TITLES = {} # rubocop:disable Style/MutableConstant
Dir.glob("#{Rails.root}/config/tasks/*.yml") do |filename|
  t = YAML.load_file(filename)
  TASKS[t['product']] = [] unless TASKS[t['product']]
  p = filename.gsub('.yml', '').gsub("#{Rails.root}/config/tasks/", "/#{t['product']}/task/")
  TASKS[t['product']].push({
    path: p,
    title: t['title'],
    is_file?: true,
    is_task?: true,
  })

  TASK_TITLES[p] = t['title']
end

module ApplicationHelper
  def search_enabled?
    defined?(ALGOLIA_CONFIG) && ENV['ALGOLIA_SEARCH_KEY']
  end

  def theme
    return unless ENV['THEME']
    "theme--#{ENV['THEME']}"
  end

  def title
    if @product && @document_title
      "Nexmo Developer | #{@product.titleize} > #{@document_title}"
    elsif @document_title
      "Nexmo Developer | #{@document_title}"
    else
      'Nexmo Developer'
    end
  end

  def directory_hash(path, name = nil)
    data = { title: (name || path), path: path }
    data[:children] = []
    # Find all markdown files on disk that are children
    Dir.foreach(path) do |entry|
      next if entry.start_with?('.')
      next if IGNORED_PATHS.include? entry
      full_path = File.join(path, entry)
      if File.directory?(full_path)
        data[:children] << directory_hash(full_path, entry)
      else
        data[:children] << { title: entry, path: full_path, is_file?: true }
      end
    end

    # Do we have tasks for this product?
    product = path.gsub(%r{.*#{@namespace_root}/}, '')
    if DocumentationConstraint.product_with_parent_list.include? product
      if TASKS[product]
        data[:children] << { title: 'tasks', path: ".#{product}/tasks", children: TASKS[product] }
      end
    end

    sort_navigation(data)
  end

  def sort_navigation(context)
    # Sort top level
    context[:children].sort_by! do |item|
      configuration_identifier = url_to_configuration_identifier(path_to_url(item[:path]))
      options = configuration_identifier.split('.').inject(NAVIGATION_OVERRIDES) { |h, k| h[k] || {} }

      sort_array = []
      sort_array << (options['navigation_weight'] || 1000) # If we have a path specific navigation weight, use that to explicitly order this
      sort_array << (item[:is_file?] ? 0 : 1) if context[:path].include? 'code-snippets' # Directories *always* go after single files for Code Snippets (priority 1 rather than 0). This even overrides config entries
      sort_array << (NAVIGATION_WEIGHT[normalised_title(item)] || 1000) # If we have a config entry for this, use it. Otherwise put it at the end
      sort_array << (item[:is_file?] ? 0 : 1) # If it's a file it gets higher priority than a directory
      sort_array << (item[:is_file?] && document_meta(item[:path])['navigation_weight'] ? document_meta(item[:path])['navigation_weight'] : 1000) # Use the config entry if we have it. Otherwise it goes to the end
      sort_array
    end

    # Sort children if needed
    context[:children].each do |child|
      sort_navigation(child) if child[:children]
    end

    context
  end

  def path_to_url(path)
    path.gsub(/.*#{@namespace_root}/, '').gsub('.md', '')
  end

  def url_to_configuration_identifier(url)
    url.tr('/', '.').sub(/^./, '')
  end

  def first_link_in_directory(context)
    return nil if context.empty?
    if context.first[:is_file?]
      path_to_url(context.first[:path])
    elsif context.first[:children]
      first_link_in_directory(context.first[:children])
    end
  end

  def normalised_title(item)
    if item[:is_task?]
      item[:title]
    elsif item[:is_file?]
      document_meta(item[:path])['navigation'] || document_meta(item[:path])['title']
    else
      I18n.t("menu.#{item[:title]}")
    end
  end

  def sidenav(path)
    context = directory_hash(path)[:children]

    if params[:namespace].present?
      context = [{
        title: params[:namespace],
        path: path.gsub('app/views', ''),
        children: context,
      }]
    end

    directory(context)
  end

  def directory(context)
    s = []

    namespace = params[:namespace].presence || 'documentation'
    s << "<ul class='Vlt-sidemenu Vlt-sidemenu--rounded navigation js-navigation navigation--#{namespace}'>"

    # Our top level folders
    s << context.map do |folder|
      configuration_identifier = url_to_configuration_identifier(path_to_url(folder[:path]))
      options = configuration_identifier.split('.').inject(NAVIGATION_OVERRIDES) { |h, k| h[k] || {} }

      ss = []
      ss << "<li class='navigation-item--#{folder[:title]} navigation-item'>"
      ss << "<a class='Vlt-sidemenu__trigger'>"

      # If we have an icon
      if options['svg'] && options['svgColor']
        ss << '<svg class="Vlt-' + options['svgColor'] + '"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-' + options['svg'] + '" /></svg>'
      end

      # Add a title
      ss << "<span class='Vlt-sidemenu__label'>#{normalised_title(folder)}"

      # And a label if there's one provided for this entry
      if options['label']
        additional_classes = generate_label_classes(options['label'])
        ss << content_tag(:span, options['label'], class: 'Vlt-badge Vlt-badge--margin-left' + additional_classes).html_safe
      end
      ss << '</span>'

      ss << '</a>'

      # Are there any subitems that need adding here?
      ss << output_children(folder[:children]) if folder[:children].length

      ss << '</li>'
      ss.join('')
    end

    s.join("\n").html_safe
  end

  def output_children(children)
    s = []
    s << '<ul class="Vlt-sidemenu__list--compressed">'

    s << children.map do |child|
      configuration_identifier = url_to_configuration_identifier(path_to_url(child[:path]))
      options = configuration_identifier.split('.').inject(NAVIGATION_OVERRIDES) { |h, k| h[k] || {} }

      ss = []
      title = normalised_title(child)

      ss << "<li class=\"navigation-item--#{title.parameterize} navigation-item\">"

      # If it's a file, add a link
      output = output_link(child, title, options) if child[:is_file?]

      # If it's a top level folder, add another dropdown
      output = output_nested_dropdown(child, title) if COLLAPSIBLE.include? title

      # Otherwise we output a header and children
      output ||= output_header_with_children(child, title)

      ss << output

      ss << '</li>'
    end

    s << '</ul>'
    s.join('')
  end

  def output_link(item, title, options)
    # Setup
    active_path = request.path
    url = path_to_url(item[:path])
    has_active_class = (url == active_path)

    # Handle tutorials
    if @navigation == :tutorials
      has_active_class = (url == "/#{@product}/tutorials")
    end

    # Output
    s = []
    s << "<a class=\"Vlt-sidemenu__link #{has_active_class ? 'Vlt-sidemenu__link_active' : ''}\" href=\"#{url}\">"

    if options['label']
      additional_classes = generate_label_classes(options['label'])
      label_content = content_tag(:span, options['label'], class: 'Vlt-badge Vlt-badge--margin-left' + additional_classes).html_safe
      s << '<span class="Vlt-sidemenu__label">'
      s << title
      s << label_content
      s << '</span>'
    else
      s << title
    end

    s << '</a>'

    s.join('')
  end

  def output_nested_dropdown(item, title)
    ss = []
    ss << "<li class=\"js--collapsible navigation-item--#{title.parameterize} navigation-item\">"
    ss << "<a class=\"Vlt-sidemenu__trigger\" href=\"/concepts\"><span class=\"Vlt-sidemenu__label\">#{title}</span></a>"
    ss << output_children(item[:children]) if item[:children]
    ss.join('')
  end

  def output_header_with_children(item, title)
    ss = []
    ss << '<h5 class="Vlt-sidemenu__title Vlt-sidemenu__title--border">' + title + '</h5>'
    ss << output_children(item[:children]) if item[:children]

    ss.join('')
  end

  def generate_label_classes(label)
    classes = ' '
    classes += 'Vlt-bg-green' if label.casecmp('beta').zero?

    classes
  end

  def document_meta(path)
    if path.include? '/task/'
      return { 'title' => TASK_TITLES[path.gsub('/task/', '')] }
    end
    YAML.load_file(path)
  end

  def show_canonical_meta?
    return true if params[:code_language].present?
    return true if Rails.env.production? && request.base_url != 'https://developer.nexmo.com'
    false
  end

  def canonical_path
    request.path.chomp("/#{params[:code_language]}")
  end

  def canonical_url
    base_url = Rails.env.production? ? 'https://developer.nexmo.com' : request.base_url
    canonical_path.prepend(base_url)
  end

  def normalize_summary_title(summary, operation_id)
    # return summary early if provided
    return summary unless summary.nil?

    # If the operation ID is camelCase,
    if operation_id.match?(/^[a-zA-Z]\w+(?:[A-Z]\w+){1,}/x)
      # Use the rails `.underscore` method to convert someString to some_string
      operation_id = operation_id.underscore
    end

    # Replace snake_case and kebab-case with spaces and titelize the string
    operation_id = operation_id.gsub(/(_|-)/, ' ').titleize

    # Some terms need to be capitalised all the time
    uppercase_array = ['SMS', 'DTMF']
    operation_id.split(' ').map do |c|
      next c.upcase if uppercase_array.include?(c.upcase)
      c
    end.join(' ')
  end
end
