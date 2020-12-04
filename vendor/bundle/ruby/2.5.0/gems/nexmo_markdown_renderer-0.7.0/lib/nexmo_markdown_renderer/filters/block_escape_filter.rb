module Nexmo
  module Markdown
    class BlockEscapeFilter < Banzai::Filter
      include Nexmo::Markdown::Concerns::PrismCodeSnippet

      def call(input)
        # Freeze to prevent Markdown formatting
        input.gsub(/````\n(.+?)````/m) do |_s|
          lexer = Rouge::Lexer.find('text')
          formatter = Rouge::Formatters::HTML.new
          highlighted_source = formatter.format(lexer.lex($1))

          output = code_snippet_body(lexer, highlighted_source)

          "FREEZESTART#{Base64.urlsafe_encode64(output)}FREEZEEND"
        end
      end
    end

  end
end
