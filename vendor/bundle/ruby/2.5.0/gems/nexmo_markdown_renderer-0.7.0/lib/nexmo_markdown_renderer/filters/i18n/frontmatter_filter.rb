module Nexmo
  module Markdown
    module I18n
      class FrontmatterFilter < Banzai::Filter
        def call(input)
          input.gsub(/\A(---.+?---)/mo) do |frontmatter|
            output = frontmatter.gsub(/^languages:\n(^\s+- ([a-zA-Z]+)\n)+/) do |languages|
              languages.gsub(/^\s+- ([a-zA-Z]+)\n+/) do |language|
                "  - ```#{$1}```\n\n"
              end
            end
            output = output.gsub(/^(\w*:)(.*)\n/) do |_key|
              if $1 == "products:"
                "```#{$1}#{$2}```\n\n"
              else
                "```#{$1}```#{$2}\n\n"
              end
            end

            output
          end
        end
      end
    end
  end
end
