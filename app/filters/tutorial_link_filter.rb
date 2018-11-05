class TutorialLinkFilter < Banzai::Filter
  def call(input)
    @input = input

    document.css('a').each_with_index do |link, _index|
      if link['href']&.start_with?('/tutorials/')
        link['data-turbolinks'] = 'false'
      end
    end

    @document.to_html
  end

  private

  def document
    @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
  end
end
