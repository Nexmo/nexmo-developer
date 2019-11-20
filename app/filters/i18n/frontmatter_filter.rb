module I18n
  class FrontmatterFilter < Banzai::Filter
    def call(input)
      input.gsub(/\A(---.+?---)/mo) do |frontmatter|
        frontmatter.gsub(/(\w*:)/) do |_key|
          "```#{$1}```"
        end
      end
    end
  end
end
