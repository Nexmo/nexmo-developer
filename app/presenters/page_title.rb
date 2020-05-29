class PageTitle
  DEFAULT = 'Vonage API Developer'.freeze

  def initialize(product, document_title)
    @product        = product
    @document_title = document_title
  end

  def title
    if @product && @document_title
      "#{@product.titleize} > #{@document_title} | #{DEFAULT}"
    elsif @document_title
      "#{@document_title} | #{DEFAULT}"
    else
      DEFAULT
    end
  end
end
