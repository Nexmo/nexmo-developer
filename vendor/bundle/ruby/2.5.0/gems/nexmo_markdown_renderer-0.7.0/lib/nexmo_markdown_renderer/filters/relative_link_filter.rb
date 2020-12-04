module Nexmo
  module Markdown
    class RelativeLinkFilter < Banzai::Filter
      def call(input)
        @input = input

        document.css('a[href^="/"]').each_with_index do |link, _index|
          link[:href] = "/#{options[:locale]}#{link[:href]}" if options[:locale]
        end

        document.to_html
      end

      private

      def document
        @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
      end
    end
  end
end
