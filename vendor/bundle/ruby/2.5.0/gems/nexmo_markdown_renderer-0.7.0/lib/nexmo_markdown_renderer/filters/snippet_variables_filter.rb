module Nexmo
  module Markdown
    class SnippetVariablesFilter < Banzai::Filter
      def call(input)
        input.gsub(/```snippet_variables(.+?)```/m) do |_s|
          config = YAML.safe_load(Regexp.last_match(1))

          raise 'No variables provided' unless config
          raise 'Must provide an array' unless config.is_a?(Array)

          output = <<~HEREDOC
            Key | Description
            -- | --
          HEREDOC
          config.each do |key|
            details = variables[key]
            raise "#{key} is not a valid snippet variable" unless details
            raise "#{key} does not have a description" unless details['description']

            output += <<~HEREDOC
              `#{key}` | #{details['description']}
            HEREDOC
          end

          output
        end
      end

      def variables
        @variables ||= YAML.safe_load(File.read("#{Nexmo::Markdown::Config.docs_base_path}/config/code_snippet_variables.yml"))
      end
    end
  end
end
