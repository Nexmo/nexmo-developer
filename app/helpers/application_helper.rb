IGNORED_PATHS = ['..', '.', '.DS_Store'].freeze
NAVIGATION = YAML.load_file("#{Rails.root}/config/navigation.yml")
NAVIGATION_WEIGHT = NAVIGATION['navigation_weight']
NAVIGATION_OVERRIDES = NAVIGATION['navigation_overrides']
FLATTEN_TREES = [].freeze
COLLAPSIBLE = ['Messages API', 'Dispatch API', 'Messaging', 'SMS', 'Conversion API', 'SNS', 'US Short Codes', 'Voice', 'Number Insight', 'Account', 'Global', 'SIP', 'Voice API'].freeze

module ApplicationHelper
  def search_enabled?
    return false unless defined? ALGOLIA_CONFIG
    return false unless ENV['ALGOLIA_SEARCH_KEY']
    true
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

    sort_navigation(data)
  end

  def sort_navigation(context)
    # Sort top level
    context[:children].sort_by! do |item|
      configuration_identifier = url_to_configuration_identifier(path_to_url(item[:path]))
      options = configuration_identifier.split('.').inject(NAVIGATION_OVERRIDES) { |h, k| h[k] || {} }

      sort_array = []
      sort_array << (options['navigation_weight'] || 1000) # If we have a path specific navigation weight, use that to explicitly order this
      sort_array << (item[:is_file?] ? 0 : 1) if context[:path].include? 'building-blocks' # Directories *always* go after single files for building blocks (priority 1 rather than 0). This even overrides config entries
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
    if item[:is_file?]
      document_meta(item[:path])['navigation'] || document_meta(item[:path])['title']
    else
      I18n.t("menu.#{item[:title]}")
    end
  end

  def sidenav(path, active_path = nil)
    context = directory_hash(path)[:children]

    if params[:namespace].present?
      context = [{
        title: params[:namespace],
        path: path.gsub('app/views', ''),
        children: context,
      }]
    end

    directory(context, true, false, active_path)
  end

  def directory(context = directory_hash("#{Rails.root}/_documentation")[:children], root = true, received_flatten = false, active_path = nil)
    active_path ||= request.path

    s = []
    unless received_flatten
      namespace = params[:namespace].presence || 'documentation'
      s << (root ? "<ul class='Vlt-sidemenu Vlt-sidemenu--rounded navigation js-navigation navigation--#{namespace}'>" : '<ul class="Vlt-sidemenu__list--compressed">')
    end
    s << context.map do |child|
      flatten = FLATTEN_TREES.include? normalised_title(child)
      class_name = (COLLAPSIBLE.include? normalised_title(child)) ? 'js--collapsible' : ''
      configuration_identifier = url_to_configuration_identifier(path_to_url(child[:path]))
      options = configuration_identifier.split('.').inject(NAVIGATION_OVERRIDES) { |h, k| h[k] || {} }
      # Rails.logger.debug(options)

      unless options['prevent_navigation_item_class']
        class_name = "#{class_name} navigation-item--#{normalised_title(child).parameterize}"
      end

      ss = []
      ss << "<li class='#{class_name} navigation-item'>" unless received_flatten

      unless flatten
        url = (child[:is_file?] ? path_to_url(child[:path]) : first_link_in_directory(child[:children]))
        has_active_class = (active_path == url) || active_path.start_with?("#{url}/")

        # Handle tutorials
        if @navigation == :tutorials
          has_active_class = url == "/#{@product}/tutorials"
        end

        if !child[:is_file?]
          if context.first[:children]
            ss << "<a class='Vlt-sidemenu__trigger'>"

            if options['svg'] && options['svgColor'] # rubocop:disable Metrics/BlockNesting
              ss << '<svg class="Vlt-' + options['svgColor'] + '"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-' + options['svg'] + '" /></svg>'
            end

            if options['label'] # rubocop:disable Metrics/BlockNesting
              additional_classes = ' '
              additional_classes += 'Vlt-bg-green' if options['label'].casecmp('beta').zero? # rubocop:disable Metrics/BlockNesting
              ss << '<span class="Vlt-sidemenu__label">'.html_safe + (normalised_title(child) + content_tag(:span, options['label'], class: 'Vlt-badge Vlt-badge--margin-left' + additional_classes)).html_safe + '</span>'.html_safe
            else
              ss << "<span class='Vlt-sidemenu__label'>#{normalised_title(child)}</span>"
            end
            ss << '</a>'
          else
            ss << "<h5 class='Vlt-sidemenu__title Vlt-sidemenu__title--border'>#{normalised_title(child)}</h5>"
          end
        elsif options['link'] == false
          ss << "<span>#{normalised_title(child)}</span>"
        else
          link = link_to url, class: "#{has_active_class ? 'Vlt-sidemenu__link Vlt-sidemenu__link_active' : 'Vlt-sidemenu__link'}" do
            if options['label']
              additional_classes = ' '
              additional_classes += 'Vlt-bg-green' if options['label'].casecmp('beta').zero? # rubocop:disable Metrics/BlockNesting
              '<span class="Vlt-sidemenu__label">'.html_safe + (normalised_title(child) + content_tag(:span, options['label'], class: 'Vlt-badge Vlt-badge--margin-left' + additional_classes)).html_safe + '</span>'.html_safe
            elsif options['svg']
              ('<svg class="Vlt-' + options['svgColor'] + '"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-' + options['svg'] + '" /></svg><span class="Vlt-sidemenu__label">').html_safe + normalised_title(child) + '</span>'.html_safe
            else
              normalised_title(child)
            end
          end

          ss << link
        end
      end

      ss << directory(child[:children], false, flatten, active_path) if child[:children]
      ss << '</li>' unless received_flatten
      ss.join("\n")
    end

    if root && @side_navigation_extra_links
      s << '<hr>'
      @side_navigation_extra_links.each do |title, path|
        s << <<~HEREDOC
          <a href="#{path}" class="#{path == active_path ? 'Vlt-sidemenu__link_active' : ''}">#{options['svg'] && options['svgColor'] ? '<svg class="Vlt-' + options['svgColor'] + '"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-' + options['svg'] + '" /></svg>' : ''} <span class='Vlt-sidemenu__label'>#{title}</span></a>
        HEREDOC
      end
    end

    s << '</ul>' unless received_flatten

    s.join("\n").html_safe
  end

  def document_meta(path)
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
