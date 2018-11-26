class ExternalLinkFilter < Banzai::Filter
  def call(input)
    @input = input

    document.css('a').each_with_index do |link, _index|
      if link['href']&.start_with?('http') && link['class'] && !link['class'].include?('no-external-marker')
        link['target'] = '_blank'
        if link.css('svg').empty?
          link.add_child <<~HEREDOC
            &nbsp;<svg class="Vlt-icon Vlt-icon--smaller Vlt-icon--text-bottom Vlt-blue-dark"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-open"></use></svg>
          HEREDOC
        end
      end
    end

    @document.to_html
  end

  private

  def document
    @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
  end
end
