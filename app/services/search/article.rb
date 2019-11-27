module Search
  class Article
    delegate :config, :title, :description, :body, :path, :doc_type, to: :@doc

    def initialize(doc, html)
      @doc  = doc
      @html = html
    end

    def relative_path
      @relative_path ||= "#{config[:base_url_path]}/#{path.relative_path_from(config[:origin])}".gsub('.md', '')
    end

    def product
      @product ||= begin
                     product = relative_path.split('/')[1]
                     if product == 'messaging'
                       "#{relative_path.split('/')[1]} > #{relative_path.split('/')[2]}"
                     else
                       product
                     end
                   end
    end

    def to_h
      {
        title: title,
        heading: @html.css('body').children[0].text.strip,
        anchor: @html.css('body').children[0].text.parameterize,
        description: description,
        document_class: doc_type,
        path: relative_path,
        document_path: path,
        body: @html.text,
        product: product,
      }
    end
  end
end
