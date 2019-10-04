class HeadingFilter < Banzai::Filter
  def call(input)
    @input = input
    @headings = []
    heading_tag_list = %w[h1 h2 h3 h4 h5 h6]
    headings = document.children.select do |child|
      heading_tag_list.include? child.name
    end

    headings.each do |heading|
      parameterized_heading = parameterized_heading_without_collision(heading)
      heading['id'] = parameterized_heading
      heading['data-id'] = SecureRandom.hex
      heading['class'] = heading[:class]
      heading['class'] += ' Vlt-title--icon'

      heading.prepend_child <<~HEREDOC
        <a href="##{parameterized_heading}" class="heading-permalink">
          <svg class="Vlt-grey"><use xlink:href=\"/symbol/volta-icons.svg#Vlt-icon-link\" /></svg>
        </a>
      HEREDOC
    end

    @document.to_html
  end

  private

  def document
    @document ||= Nokogiri::HTML::DocumentFragment.parse(@input)
  end

  def parameterized_heading_without_collision(heading)
    parameterized_heading = nil
    index = nil

    loop do
      if index
        parameterized_heading = "#{heading.text.parameterize}-#{index}"
        index += 1
      else
        parameterized_heading = heading.text.parameterize
        index = 2
      end

      break if @headings.exclude? parameterized_heading
    end

    @headings << parameterized_heading
    parameterized_heading
  end
end
