module Nexmo
  module Markdown
    class FrontmatterFilter < Banzai::Filter
      def call(input)
        # Remove frontmatter from the input
        input.gsub(/\A(---.+?---)/mo, '')
      end
    end
    
  end
end