module Nexmo
  module Markdown
    class UseCase
      include ActiveModel::Model
      attr_accessor :title, :description, :external_link, :products, :document_path, :languages, :root

      def body
        File.read(document_path)
      end

      def relative_path
        document_path.relative_path_from(self.class.origin).sub(/\w{2}\//, '').to_s.gsub('.md', '')
      end

      def path
        return external_link if external_link

        "/use-cases/#{relative_path}"
      end

      def subtitle
        normalized_products = products.map do |product|
          Product.normalize_title(product)
        end

        normalized_products.sort.to_sentence
      end

      def self.by_product(product, use_cases = [])
        use_cases = all if use_cases.empty?
        use_cases.select do |use_case|
          use_case.products.include? product
        end
      end

      def self.by_language(language, use_cases = [])
        language = language.downcase
        use_cases = all if use_cases.empty?

        use_cases.select do |use_case|
          use_case.languages.map(&:downcase).include? language
        end
      end

      def self.origin
        Pathname.new("#{Nexmo::Markdown::Config.docs_base_path}/_use_cases")
      end

      def self.all
        files.map do |document_path|
          document_path = Pathname.new(document_path)
          document = File.read(document_path)
          frontmatter = YAML.safe_load(document)

          new({
            title: frontmatter['title'],
            description: frontmatter['description'],
            external_link: frontmatter['external_link'],
            products: frontmatter['products'].split(',').map(&:strip),
            languages: frontmatter['languages'] || [],
            document_path: document_path,
            root: origin.to_s,
          })
        end
      end

      private_class_method def self.files
        Dir.glob("#{origin}/**/*.md")
      end
    end
  end
end
