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

    if content[:language]
      tab['data-language'] = content[:language].key
      tab['data-language-type'] = content[:language].type
      tab['data-language-linkable'] = content[:language].linkable?
    end

    if content[:platform]
      tab['data-language'] = content[:platform].languages.map(&:key).join(',')
      tab['data-platform'] = content[:platform].key
      tab['data-platform-type'] = content[:platform].type
      tab['data-platform-linkable'] = content[:platform].linkable?
    end

    tab_link = Nokogiri::XML::Element.new 'a', @document
    tab_link.inner_html = "<svg><use xlink:href=\"/assets/images/brands/#{content[:language].key}.svg##{content[:language].key}\" /></svg><span>" + content[:tab_title] + '</span>'
    tab_link['href'] = "##{content[:id]}"

    tab.add_child(tab_link)
    @tabs.add_child(tab)
  end

  def create_content(content)
    element = Nokogiri::XML::Element.new 'div', @document
    element['id'] = content[:id]
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

    list = resolve_language(list)

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

      content = YAML.safe_load(source)
      content[:id] = SecureRandom.hex
      content[:source] = source
      content[:language_key] = content['language']
      content[:platform_key] = content['platform']
      content[:tab_title] = content['title']

      parent_config = { 'code_only' => @config['code_only'], 'source' => @config['source'].gsub('_examples/', '') }
      if @config['application']
        parent_config = parent_config.merge({ 'application' => @config['application'] })
      end

      parent_config = parent_config.to_yaml.lines[1..-1].join

      source = <<~HEREDOC
        ```single_building_block
        #{source}\n#{parent_config}
        ```
      HEREDOC

      content[:body] = MarkdownPipeline.new(options).call(source)

      content
    end
  end

  def resolve_language(contents)
    contents.map do |content|
      if content[:language_key]
        content[:language] = CodeLanguageResolver.find(content[:language_key])
      end

      if content[:platform_key]
        content[:platform] = CodeLanguageResolver.find(content[:platform_key])
      end

      content
    end
  end

  def sort_contents(contents)
    contents.sort_by do |content|
      next content[:language].weight if content[:language]
      next content[:frontmatter]['menu_weight'] || 999 if content[:frontmatter]
      999
    end
  end

  def resolve_active_tab(contents)
    active_index = nil

    if options[:code_language]
      contents.each_with_index do |content, index|
        %i[language_key platform_key].each do |key|
          active_index = index if content[key] == options[:code_language].key
        end
      end
    end

    @tabs['data-has-initial-tab'] = active_index.present?
    active_index ||= 0

    contents[active_index][:active] = true
  end
end
