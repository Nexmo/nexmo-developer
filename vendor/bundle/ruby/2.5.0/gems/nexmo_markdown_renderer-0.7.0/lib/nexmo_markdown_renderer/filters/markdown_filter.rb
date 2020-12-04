module Nexmo
  module Markdown
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
      include Nexmo::Markdown::Concerns::PrismCodeSnippet

      def initialize(options)
        @options = options
        super(options)
      end

      def paragraph(text)
        return text if @options[:skip_paragraph_surround]

        "<p>#{text}</p>"
      end

      def table(header, body)
        '<div class="Vlt-table Vlt-table--bordered">' \
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
          '" alt="'\
          "#{_alt_text}"\
          '">' \
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

      def block_code(code, language)
        lexer = ::Rouge::Lexer.find_fancy(language, code) || ::Rouge::Lexers::PlainText

        # XXX HACK: Redcarpet strips hard tabs out of code blocks,
        # so we assume you're not using leading spaces that aren't tabs,
        # and just replace them here.
        if lexer.tag == 'make'
          code.gsub! /^    /, "\t"
        end

        formatter ||= Rouge::Formatters::HTML.new
        highlighted_source = formatter.format(lexer.lex(code))

        code_snippet_body(lexer, highlighted_source)
      end
    end
  end
end

