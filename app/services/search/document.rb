module Search
  class Document
    attr_reader :doc_type, :config, :path

    def initialize(doc_type, config, path)
      @doc_type = doc_type
      @config   = config
      @path     = Pathname.new(path)
    end

    def articles
      @articles ||= Nokogiri::HTML(body).split_html.map do |section_html|
        Search::Article.new(self, section_html)
      end
    end

    def document
      @document ||= File.read(@path)
    end

    def frontmatter
      @frontmatter ||= YAML.safe_load(document)
    end

    def title
      @title ||= frontmatter['title']
    end

    def description
      @description ||= frontmatter['description']
    end

    def body
      @body ||= MarkdownPipeline.new.call(document)
    end
  end
end
