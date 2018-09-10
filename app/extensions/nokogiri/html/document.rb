module Nokogiri
  module HTML
    class Document
      def split_html
        sections = []

        css('body').children.each_with_index do |child, index|
          if index.zero? || %w[h1 h2 h3 h4 h5 h6].include?(child.name)
            sections << [child]
          else
            sections.last << child unless child.text == "\n"
          end
        end

        sections.map! do |section|
          Nokogiri::HTML(section.map(&:to_html).join)
        end

        sections
      end
    end
  end
end
