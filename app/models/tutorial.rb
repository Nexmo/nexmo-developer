class Tutorial
  include ActiveModel::Model
  attr_accessor :title, :description, :products, :document_path, :languages

  def body
    File.read(document_path)
  end

  def path
    "/tutorials/#{document_path.relative_path_from(Tutorial.origin)}".gsub('.md', '')
  end

  def subtitle
    normalized_products = products.map do |product|
      normalise_product_title(product)
    end

    normalized_products.sort.to_sentence
  end

  private

  def normalise_product_title(product)
    return 'SMS' if product == 'messaging/sms'
    return 'Voice' if product == 'voice/voice-api'
    return 'Number Insight' if product == 'number-insight'
    product.camelcase
  end

  def self.by_product(product)
    all.select do |tutorial|
      tutorial.products.include? product
    end
  end

  def self.all
    files.map do |document_path|
      document_path = Pathname.new(document_path)
      document = File.read(document_path)
      frontmatter = YAML.safe_load(document)

      Tutorial.new({
        title: frontmatter['title'],
        description: frontmatter['description'],
        products: frontmatter['products'].split(',').map(&:strip),
        languages: frontmatter['languages'] || [],
        document_path: document_path,
      })
    end
  end

  private

  def self.files
    Dir.glob("#{origin}/**/*.md")
  end

  def self.origin
    Pathname.new("#{Rails.root}/_tutorials")
  end
end
