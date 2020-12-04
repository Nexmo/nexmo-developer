module Nexmo
  module Markdown
    module I18n
      module Smartling
        class CodeBlockFilter < Banzai::Filter
          def call(input)
            input.gsub(/\n\n\s{4}(.*?)\n\n/m) do
              <<~CODE_BLOCK

                ````
                #{$1.split(/\n\s{4}/).join("\n")}
                ````
              CODE_BLOCK
            end
          end
        end
      end
    end
  end
end
