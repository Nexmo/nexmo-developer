class SearchTerms
  def self.generate
    # TODO: make this work with different locales
    document_paths = {
      documentation: {
        documents: Dir.glob("#{Rails.root}/_documentation/en/**/*.md"),
        origin: Pathname.new("#{Rails.root}/_documentation/en"),
        base_url_path: '',
      },
      api: {
        documents: Dir.glob("#{Rails.root}/_api/**/*.md"),
        origin: Pathname.new("#{Rails.root}/_api"),
        base_url_path: '/api',
      },
      use_cases: {
        documents: Dir.glob("#{Rails.root}/_use_cases/en/**/*.md"),
        origin: Pathname.new("#{Rails.root}/_use_cases/en"),
        base_url_path: '/use-cases',
      },
    }

    document_paths.map do |document_class, config|
      config[:documents].map do |document_path|
        Search::Document.new(document_class, config, document_path).articles.map(&:to_h)
      end
    end.flatten
  end
end
