class Career
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
    CGI.unescapeHTML(@career[:content])
  end

  def url
    @career[:absolute_url]
  end
end
