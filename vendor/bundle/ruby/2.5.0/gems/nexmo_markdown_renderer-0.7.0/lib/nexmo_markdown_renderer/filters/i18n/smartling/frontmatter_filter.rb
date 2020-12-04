module Nexmo
  module Markdown
    module I18n
      module Smartling
        class FrontmatterFilter < Banzai::Filter
          def call(input)
            input.gsub(/\A\*\*\* \*\* \* \*\* \*\*\*\n*(.*\n)!?(----+|\*\*\* \*\* \* \*\* \*\*\*)\n*/m) do |_frontmatter|
              front = $1.gsub(/`products: (.*)`\n\n/) do |products|
                "products: #{$1}\n\n"
              end

              front = front.gsub(/`(.*):`(.*)/) do |_config|
                "#{$1}: #{$2}"
              end

              front = front.gsub(/languages: \n\n(.*)\n/m) do |_languages|
                languages = $1.split("\n\n").map do |lang|
                  lang.gsub(/\* `(.*)`/) { |_l| "  - #{$1}" }
                end
                <<~LANGUAGES
                languages:
                #{languages.join("\n")}
                LANGUAGES
              end

              <<~FRONTMATTER
                ---
                #{front}
                ---

              FRONTMATTER
            end
          end
        end
      end
    end
  end
end
