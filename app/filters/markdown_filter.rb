class MarkdownFilter < Banzai::Filter
  def call(input)
    markdown.render(input)
  end

  private

  def renderer
    @renderer ||= VoltaRender.new(options)
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(renderer, {
      no_intra_emphasis: true,
      tables: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      start_inline: true,
    })
  end
end

class VoltaRender < HTML
  def initialize(options)
    @options = options
    super(options)
  end

  def paragraph(text)
    return text if @options[:skip_paragraph_surround]

    "<p>#{text}</p>"
  end

  def table(header, body)
    '<div class="Vlt-table Vlt-table--data Vlt-table--bordered">' \
    '<table>' \
      "<thead>#{header}</thead>" \
      "<tbody>#{body}</tbody>" \
    '</table>' \
    '</div>'
  end

  def block_quote(quote)
    '<div class="Vlt-callout Vlt-callout--tip">' \
      '<i></i>' \
      '<div class="Vlt-callout__content">' \
        "#{quote}" \
      '</div>' \
    '</div>'
  end

  def image(link, _title, _alt_text)
    '<figure>' \
      '<img src="'\
      "#{link}"\
      '" alt="#{alt_text}">' \
    '</figure>'
  end

  def list(contents, list_type)
    if "#{list_type}" == 'unordered'
      '<ul class="Vlt-list Vlt-list--simple">' \
      "#{contents}" \
      '</ul>'
    else
      '<ol class="Vlt-list Vlt-list--simple">' \
      "#{contents}" \
      '</ol>' \
    end
  end
end
