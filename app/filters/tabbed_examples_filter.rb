class TabbedExamplesFilter < Banzai::Filter
  def call(input)
    input.gsub(/```tabbed_examples(.+?)```/m) do |_s|
      @config = YAML.safe_load($1)

      @examples = @config['source'] ? load_examples_from_source : load_examples_from_tabs
      @examples = sort_examples

      build_html
    end
  end

  private

  def load_examples_from_source
    examples_path = "#{Rails.root}/#{@config['source']}"
    dir_safe_examples_path = examples_path.gsub /(\{|\}|\s)/ do
      "\\#{$1}"
    end

    Dir["#{dir_safe_examples_path}/*"].map do |example_path|
      language = example_path.sub("#{examples_path}/", '').downcase
      source = File.read(example_path)
      { language: language, source: source }
    end
  end

  def load_examples_from_tabs
    @config['tabs'].map do |title, config|
      source = File.read(config['source'])

      total_lines = source.lines.count
      from_line = config['from_line'] || 0
      to_line = config['to_line'] || total_lines

      source = source.lines[from_line..to_line].join

      { language: title.dup.downcase, source: source }
    end
  end

  def sort_examples
    @examples.sort_by do |example|
      if language_configuration[example[:language]]
        language_configuration[example[:language]]['weight'] || 1000
      else
        1000
      end
    end
  end

  def active_class(index, language, options = {})
    if options[:code_language] && language_exists?(options[:code_language])
      'is-active' if language == options[:code_language]
    elsif index.zero?
      'is-active'
    end
  end

  def language_exists?(language)
    @examples.detect { |example| example[:language] == language }
  end

  def language_data(example)
    language = example[:language]
    configuration = language_configuration[language]
    return unless configuration

    <<~HEREDOC
      data-language="#{language}"
      data-language-linkable="#{configuration['linkable'] != false}"
    HEREDOC
  end

  def build_html
    examples_uid = "code-#{SecureRandom.uuid}"

    tabs = []
    content = []

    tabs << "<ul class='tabs tabs--code' data-tabs id='#{examples_uid}' data-initial-language=#{options[:code_language]}>"
    content << "<div class='tabs-content tabs-content--code' data-tabs-content='#{examples_uid}'>"

    @examples.each_with_index do |example, index|
      example_uid = "code-#{SecureRandom.uuid}"
      tabs << <<~HEREDOC
        <li class="tabs-title #{active_class(index, example[:language], options)}" #{language_data(example)}>
          <a href="##{example_uid}">#{language_label(example[:language])}</a>
        </li>
      HEREDOC
      highlighted_source = highlight(example[:source], example[:language])

      # Freeze to prevent Markdown formatting edge cases
      highlighted_source = "FREEZESTART#{Base64.urlsafe_encode64(highlighted_source)}FREEZEEND"

      content << <<~HEREDOC
        <div class="tabs-panel #{active_class(index, example[:language], options)}" id="#{example_uid}" aria-hidden="#{!!!active_class(index, example[:language], options)}">
          <pre class="highlight #{example[:language]}"><code>#{highlighted_source}</code></pre>
        </div>
      HEREDOC
    end

    tabs << '</ul>'
    content << '</div>'

    # Wrap in an extra Div prevents markdown for formatting
    "<div>#{tabs.join('')}#{content.join('')}</div>"
  end

  def highlight(source, language)
    formatter = Rouge::Formatters::HTML.new
    lexer = language_to_lexer(language)
    formatter.format(lexer.lex(source))
  end

  def language_label(language)
    if language_configuration[language]
      language_configuration[language]['label']
    else
      language
    end
  end

  def language_to_lexer_name(language)
    if language_configuration[language]
      language_configuration[language]['lexer']
    else
      language
    end
  end

  def language_to_lexer(language)
    language = language_to_lexer_name(language)
    Rouge::Lexer.find(language) || Rouge::Lexer.find('text')
  end

  def language_configuration
    @language_configuration ||= YAML.load_file("#{Rails.root}/config/code_languages.yml")
  end
end
