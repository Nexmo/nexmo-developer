class PageTitle
  def initialize(product, document_title)
    @product        = product
    @document_title = document_title
  end

  def title
    if @product && @document_title
      "#{product_title_from_config(@product)} > #{@document_title} | #{default_title}"
    elsif @document_title
      "#{@document_title} | #{default_title}"
    else
      default_title
    end
  end

  def product_title_from_config(product)
    config = load_config
    item = config['products'].select { |config_product| config_product['path'] == product }[0]
    item['name']
  end

  def load_config
    @load_config ||= begin
      path ||= "#{Rails.configuration.docs_base_path}/config/products.yml"
      raise 'You must provide a config/products.yml file in your documentation path.' unless File.exist?(path)

      YAML.safe_load(File.open(path))
    end
  end

  def default_title
    @default_title ||= begin
      config = YAML.safe_load(File.open("#{Rails.configuration.docs_base_path}/config/header_meta.yml"))
      config['title']
    end
  end
end
