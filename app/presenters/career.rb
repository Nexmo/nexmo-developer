class Career
  HEADING_TAG_LIST = %w[h1 h2 h3 h4 h5 h6].freeze
  DEPARTMENTS = YAML.safe_load(File.read('config/greenhouse_departments.yml'))

  def initialize(career)
    @career = career
  end

  def title
    @career[:title]
  end

  def location
    @career.dig(:location, :name)
  end

  def department_codes
    @department_codes ||= @career[:departments].map { |d| d[:id] }
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

  def devrel?
    @career[:departments].any? { |d| d[:id] == Greenhouse::DEPARTMENT_ID } &&
      @career[:title].downcase.match?(Regexp.union(Greenhouse::TITLES))
  end
end
