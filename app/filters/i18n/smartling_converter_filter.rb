module I18n
  class SmartlingConverterFilter < Banzai::Filter
    def call(input)
      input.gsub(/\A\*\*\* \*\* \* \*\* \*\*\*\n*(.*)\n*------------------------------------------/m) do |_frontmatter|
        front = $1.gsub(/`(.*):`(.*)/) do |_config|
          "#{$1}:#{$2}"
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
