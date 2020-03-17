class DocumentationConstraint
  def self.documentation
    Nexmo::Markdown::CodeLanguage.route_constraint.merge(product_with_parent)
  end

  def self.products_for_routes
    product_with_parent_list
  end

  def self.product_with_parent
    { product: Regexp.new(product_with_parent_list.compact.reverse.join('|')) }
  end

  def self.product_with_parent_list
    raise ArgumentError, "The 'product' key in config/products.yml must be a list with at least one entry." if config.fetch('products', []).size.zero?

    @product_with_parent_list ||= config.fetch('products', [])
  end

  def self.config
    @config ||= YAML.safe_load(
      File.read("#{Rails.configuration.docs_base_path}/config/products.yml")
    )
  end
end
