class Concept
  include ActiveModel::Model

  ORIGIN = "#{Rails.configuration.docs_base_path}/_documentation".freeze

  FILES = [
    Dir.glob("#{ORIGIN}/#{I18n.default_locale}/**/guides/**/*.md"),
    Dir.glob("#{ORIGIN}/#{I18n.default_locale}/**/concepts/**/*.md"),
  ].flatten

  attr_accessor :title, :product, :description, :navigation_weight, :document_path, :url, :ignore_in_list

  def self.by_name(names, language)
    matches = all(language).select do |block|
      concept = "#{block.product}/#{block.filename}"
      match = names.include?(concept)
      names.delete(concept) if match
      match
    end

    raise "Could not find concepts: #{names.join(', ')}" unless names.empty?

    matches
  end

  def self.by_product(product, language)
    all(language).select do |block|
      block.product == product
    end
  end

  def filename
    Pathname(document_path).basename.to_s.gsub('.md', '')
  end

  def self.all(language)
    blocks = files(language).map do |document_path|
      document = File.read(document_path)
      product = extract_product(document_path)

      frontmatter = YAML.safe_load(document)

      Concept.new({
        title: frontmatter['title'],
        description: frontmatter['description'],
        navigation_weight: frontmatter['navigation_weight'] || 999,
        ignore_in_list: frontmatter['ignore_in_list'],
        product: product,
        document_path: document_path,
        url: generate_url(document_path, language),
      })
    end

    blocks.sort_by(&:navigation_weight)
  end

  def self.generate_url(path, language)
    '/' + path.gsub("#{ORIGIN}/#{language}/", '').gsub('.md', '')
  end

  def self.extract_product(path)
    # Remove the prefix
    path = path.gsub!(%r{#{ORIGIN}\/[a-z]{2}\/}, '')

    # Each file is in the form guides/<title>.md, so let's remove the last two segments
    parts = path.split('/')
    parts = parts[0...-2]

    # What's left once we remove the start and end of the path is our product name. This could be any number
    # of parts, but it's generally 1-2
    parts.join('/')
  end

  def self.files(language)
    FILES.each_with_object([]) do |file, array|
      document = file.gsub("#{ORIGIN}/#{I18n.default_locale}/", '')
      array << DocFinder.find(root: ORIGIN, document: document, language: language)
    end
  end
end
