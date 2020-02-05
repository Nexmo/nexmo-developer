class TutorialListItem
  attr_accessor :product

  def initialize(path)
    @path = path
  end

  def tutorial
    @tutorial ||= Tutorial.load(File.basename(@path, '.yml'), nil)
  end

  def subtitle
    products
      .map { |product| Product.normalize_title(product) }
      .sort
      .to_sentence
  end

  def languages
    (tutorial.raw['languages'] || tutorial.available_languages).map(&:downcase)
  end

  def root
    'config/tutorials'
  end

  def path
    @path.gsub("#{Rails.root}/", '')
  end

  def filename
    File.basename(@path, '.yml')
  end

  def external_link
    tutorial.metadata['external_link']
  end

  def title
    tutorial.metadata['title']
  end

  def description
    tutorial.metadata['description']
  end

  def products # rubocop:disable Rails/Delegate
    tutorial.products
  end

  # rubocop:disable Naming/PredicateName
  def is_file?
    true
  end

  def is_task?
    true
  end
  # rubocop:enable Naming/PredicateName

  def first_step
    return if tutorial.metadata['external_link']

    tutorial.first_step
  end

  def product_url
    "/#{products.join('')}/tutorials"
  end

  def url
    external_link || "/#{products.join('')}/tutorials/#{filename}"
  end

  def available_languages
    languages.map do |language|
      OpenStruct.new(
        language: language,
        label: CodeLanguage.find(language).label,
        url: external_link || "/#{products.join('')}/tutorials/#{filename}/#{first_step}/#{language}"
      )
    end
  end

  def as_json
    {
      root: root,
      path: path,
      filename: filename,
      external_link: external_link,
      first_step: first_step,
      languages: languages,
      title: title,
      description: description,
      products: products,
      subtitle: subtitle,
      is_file?: is_file?,
      is_task?: is_task?,
      product: product,
    }
  end
end
