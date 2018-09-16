class BuildingBlock
  include ActiveModel::Model
  attr_accessor :title, :product, :navigation_weight, :document_path, :url

  def self.by_product(product)
    all.select do |block|
      block.product == product
    end
  end

  def self.all
    blocks = files.map do |document_path|
      document = File.read(document_path)
      product = extract_product(document_path)

      frontmatter = YAML.safe_load(document)

      BuildingBlock.new({
        title: frontmatter['title'],
        navigation_weight: frontmatter['navigation_weight'] || 999,
        product: product,
        document_path: document_path,
        url: generate_url(document_path),
      })
    end

    blocks.sort_by(&:navigation_weight)
  end

  def self.generate_url(path)
    '/' + path.gsub("#{origin}/", '').gsub('.md', '')
  end

  def self.extract_product(path)
    # Remove the prefix
    path = path.gsub!("#{origin}/", '')

    # Each file is in the form building-blocks/<title>.md, so let's remove the last two segments
    parts = path.split('/')
    parts = parts[0...-2]

    # What's left once we remove the start and end of the path is our product name. This could be any number
    # of parts, but it's generally 1-2
    parts.join('/')
  end

  def self.files
    Dir.glob("#{origin}/**/building-blocks/**/*.md")
  end

  def self.origin
    "#{Rails.root}/_documentation"
  end
end
