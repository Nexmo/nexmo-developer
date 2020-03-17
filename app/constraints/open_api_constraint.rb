class OpenApiConstraint
  OPEN_API_PRODUCTS = Dir.glob("#{Rails.configuration.oas_path}/**/*.yml").map do |dir|
    dir.gsub("#{Rails.configuration.oas_path}/", '').gsub('.yml', '')
  end

  def self.list
    @list ||= OPEN_API_PRODUCTS.sort.reject { |d| d.include? 'common/' }
  end

  def self.products
    { definition: Regexp.new("^(#{list.join('|')})$") }
  end

  def self.errors_available
    all = list.dup.concat(['application'])
    { definition: Regexp.new(all.join('|')) }
  end

  def self.products_with_code_language
    products.merge(Nexmo::Markdown::CodeLanguage.route_constraint)
  end

  def self.find_all_versions(name)
    # Remove the .v2 etc if needed
    name = name.gsub(/(\.v\d+)/, '')

    matches = list.select do |s|
      s.starts_with?(name) && !s.include?("#{name}/")
    end

    matches = matches.map do |s|
      m = /\.v(\d+)/.match(s)
      next { 'version' => '1', 'name' => s } unless m

      { 'version' => m[1], 'name' => s }
    end

    matches.sort_by { |v| v['version'] }
  end

  def self.match?(definition, code_language = nil)
    if code_language.nil?
      products_with_code_language[:definition].match?(definition)
    else
      products_with_code_language[:definition].match?(definition) &&
        products_with_code_language[:code_language].match?(code_language)
    end
  end
end
