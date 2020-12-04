class ProductDropdownPresenter
  class Option
    def initialize(product)
      @product = product
    end

    def path
      @path ||= @product['path']
    end

    def icon
      @icon ||= @product['icon']
    end

    def name
      @name ||= @product['name']
    end
  end

  def initialize(scope)
    @scope = scope
  end

  def options
    @options ||= begin
      products.select { |p| scoped_products.include?(p['path']) }.map do |p|
        Option.new(p)
      end
    end
  end

  def scoped_products
    @scoped_products ||= @scope.map(&:products).flatten.uniq
  end

  def products
    @products ||= Product.all.select { |p| p['dropdown'] == true }
  end
end
