module Nexmo
  module Markdown
    module I18n
      module Smartling
        class EscapeFilter < Banzai::Filter
          def call(input)
            input.gsub('\-', '-').gsub('\|', '|').gsub('\[', '[').gsub('\]', ']').gsub('\(', '(').gsub('\)', ')').gsub(/^>\s\n+/, "\n")
          end
        end
      end
    end
  end
end
