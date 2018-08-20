class ExternalLinkFilter < Banzai::Filter
  def call(input)
    @input = input

    document.css('a').each_with_index do |link, _index|
      if link['href']&.start_with?('http')
        link['target'] = '_blank'
        if link.css('.icon-external-link').empty?
          link.add_child <<~HEREDOC
            &nbsp;<i class="icon icon-external-link"></i>
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
