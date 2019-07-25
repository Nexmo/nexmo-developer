class Tutorial
  include ActiveModel::Model
  attr_accessor :title, :description, :external_link, :products, :document_path, :languages

  def body
    File.read(document_path)
  end

  def path
    return external_link if external_link
    "/tutorials/#{document_path.relative_path_from(Tutorial.origin)}".gsub('.md', '')
  end

  def subtitle
    normalized_products = products.map do |product|
      normalise_product_title(product)
    end

    normalized_products.sort.to_sentence
  end

  def normalise_product_title(product)
    return 'SMS' if product == 'messaging/sms'
    return 'Voice' if product == 'voice/voice-api'
    return 'Number Insight' if product == 'number-insight'
    return 'Messages' if product == 'messages'
    return 'Dispatch' if product == 'dispatch'
    return 'Client SDK' if product == 'client-sdk'
    return 'Subaccounts' if product == 'account/subaccounts'
    product.camelcase
  end

  def self.by_product(product, tutorials = [])
    tutorials = all if tutorials.empty?
    tutorials.select do |tutorial|
      tutorial.products.include? product
    end
  end

  def self.by_language(language, tutorials = [])
    language = language.downcase
    tutorials = all if tutorials.empty?

    tutorials.select do |tutorial|
      tutorial.languages.map(&:downcase).include? language
    end
  end

  def self.origin
    Pathname.new("#{Rails.root}/_tutorials")
  end

  def self.all
    files.map do |document_path|
      document_path = Pathname.new(document_path)
      document = File.read(document_path)
      frontmatter = YAML.safe_load(document)

      Tutorial.new({
        title: frontmatter['title'],
        description: frontmatter['description'],
        external_link: frontmatter['external_link'],
        products: frontmatter['products'].split(',').map(&:strip),
        languages: frontmatter['languages'] || [],
        document_path: document_path,
      })
    end
  end

  private

  private_class_method def self.files
    Dir.glob("#{origin}/**/*.md")
  end
end
