class BuildingBlocksFilter < Banzai::Filter
  def call(input)
    input.gsub(/^(\s*)```building_blocks(.+?)```/m) do |_s|
      @indentation = $1
      @config = YAML.safe_load($2)
      validate_config
      html
    end
  end

  private

  def create_tabs(content)
    tab = Nokogiri::XML::Element.new 'li', @document
    tab['class'] = 'tabs-title'
    tab['class'] += ' is-active' if content[:active]

    if content['language']
      tab['data-language'] = content['language']
      tab['data-language-type'] = content['language_type']
      tab['data-language-linkable'] = true
    end

    tab_link = Nokogiri::XML::Element.new 'a', @document
    tab_link.inner_html = "<svg><use xlink:href=\"/assets/images/brands/#{content['icon']}.svg##{content['icon']}\" /></svg><span>" + content['title'] + '</span>'
    tab_link['href'] = "##{content['id']}"

    tab.add_child(tab_link)
    @tabs.add_child(tab)
  end

  def create_content(content)
    element = Nokogiri::XML::Element.new 'div', @document
    element['id'] = content['id']
    element['class'] = 'tabs-panel'
    element['class'] += ' is-active' if content[:active]
    element.inner_html = content[:body]

    @tabs_content.add_child(element)
  end

  def html
    id = SecureRandom.hex

    html = <<~HEREDOC
      <div>
        <ul class="tabs" data-tabs id="#{id}"></ul>
        <div class="tabs-content" data-tabs-content="#{id}"></div>
      </div>
    HEREDOC

    @document = Nokogiri::HTML::DocumentFragment.parse(html)
    @tabs = @document.at_css('.tabs')
    @tabs_content = @document.at_css('.tabs-content')

    contents.each do |content|
      create_tabs(content)
      create_content(content)
    end

    source = @document.to_html

    "#{@indentation}FREEZESTART#{Base64.urlsafe_encode64(source)}FREEZEEND"
  end

  def contents
    list = content_from_source
    list ||= []

    return list unless list.any?

    list = sort_contents(list)
    resolve_active_tab(list)

    list
  end

  def validate_config
    return if @config && @config['source']
    raise 'A source key must be present in this building_blocks config'
  end

  def content_from_source
    source_path = "#{Rails.root}/#{@config['source']}/*.yml"

    Dir[source_path].map do |content_path|
      source = File.read(content_path)

      # Load the defaults for this language
      filename = File.basename(content_path, '.yml')
      defaults = CodeLanguageResolver.find(filename)

      content = YAML.safe_load(source)
      content['source'] = source
      content['id'] = SecureRandom.hex
      content['title'] ||= defaults.label
      content['language'] ||= defaults.key
      content['language_type'] ||= defaults.type
      content['dependencies'] ||= defaults.dependencies
      content['icon'] = defaults.icon
      content['weight'] ||= defaults.weight
      content['run_command'] ||= defaults.run_command
      content['unindent'] = defaults.unindent || false

      # If we don't have a file_name in config, use the one in the repo
      content['file_name'] ||= File.basename(content['code']['source'])

      parent_config = { 'code_only' => @config['code_only'], 'source' => @config['source'].gsub('_examples/', '') }
      if @config['application']
        parent_config = parent_config.merge({ 'application' => @config['application'] })
      end

      parent_config = parent_config.to_yaml.lines[1..-1].join

      source = <<~HEREDOC
        ```single_building_block
        #{content.to_yaml}\n#{parent_config}
        ```
      HEREDOC

      content[:body] = MarkdownPipeline.new(options).call(source)

      content
    end
  end

  def sort_contents(contents)
    contents.sort_by do |content|
      content['weight']
    end
  end

  def resolve_active_tab(contents)
    active_index = nil

    if options[:code_language]
      contents.each_with_index do |content, index|
        active_index = index if content['language'] == options['language_key'].key
      end
    end

    @tabs['data-has-initial-tab'] = active_index.present?
    active_index ||= 0

    contents[active_index][:active] = true
  end
end
