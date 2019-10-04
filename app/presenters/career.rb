class Career
  HEADING_TAG_LIST = %w[h1 h2 h3 h4 h5 h6].freeze

  def initialize(career)
    @career = career
  end

  def title
    @career[:title]
  end

  def location
    @career.dig(:location, :name)
  end

  def description
    content = CGI.unescapeHTML(@career[:content])

    # If it starts with a header, strip it out
    document = Nokogiri::HTML::DocumentFragment.parse(content)
    first_child = document.children[0]
    first_child.remove if HEADING_TAG_LIST.include?(first_child.name)

    document.to_html
  end

  def url
    @career[:absolute_url]
  end
end
