module Nexmo
  module Markdown
    class Utils
      def self.generate_source_url(code)
        # Source example: .repos/vonage/vonage-java-code-snippets/ExampleClass.java
        # Direct link on GitHub is in form https://github.com/vonage/vonage-java-code-snippets/blob/master/ExampleClass.java
        start_section = 'https://github.com'

        # Insert "blob/master" and strip ".repos"
        repo_path = '\\0blob/master/'
        file_section = code['source'].sub('.repos', '').sub(%r{(-quickstart|-code-snippets|-code-snippets)/}, repo_path)

        # Line highlighting
        line_section = ''
        if code['from_line']
          line_section += "#L#{code['from_line']}"
          if code['to_line']
            # If we've provided a to_line, use that
            line_section += "-L#{code['to_line']}" if code['to_line']
          else
            # By default we read to the end of the file
            line_section += "-L#{File.read("#{Nexmo::Markdown::Config.docs_base_path}/#{code['source']}").lines.count}"
          end
        end

        start_section + file_section + line_section
      end

      def self.generate_code_block(language, input, unindent)
        return '' unless input
        filename = "#{Nexmo::Markdown::Config.docs_base_path}/#{input['source']}"
        raise "CodeSnippetFilter - Could not load #{filename} for language #{language}" unless File.exist?(filename)

        code = File.read(filename)
        lexer = Nexmo::Markdown::CodeLanguage.find(language).lexer

        total_lines = code.lines.count

        # Minus one since lines are not zero-indexed
        from_line = (input['from_line'] || 1) - 1
        to_line = (input['to_line'] || total_lines) - 1

        code = code.lines[from_line..to_line].join
        code.unindent! if unindent
        formatter = Rouge::Formatters::HTML.new
        formatter.format(lexer.lex(code))
      end
    end
  end
end
