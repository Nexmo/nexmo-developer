module Translator
  class FileTranslator
    include Utils

    attr_reader :doc_path

    def initialize(doc_path)
      @doc_path = doc_path
    end

    def translation_requests
      @translation_requests ||= begin
        I18n.available_locales.reject { |l| l.to_s == I18n.default_locale.to_s }.map do |locale|
          Translator::TranslationRequest.new(
            locale: locale_with_region(locale),
            frequency: frequency,
            file_uri: uri,
            file_path: full_path
          )
        end
      end
    end

    def uri
      @uri ||= file_uri(doc_path)
    end

    def frontmatter
      @frontmatter ||= YAML.safe_load(File.read(full_path))
    end

    def full_path
      @full_path ||= "#{Rails.configuration.docs_base_path}/#{doc_path}"
    end

    def frequency
      @frequency ||= frontmatter['translation_frequency'] || product_translation_frequency
    end

    def product_from_path
      @product_from_path ||= begin
        Pathname.new(
          doc_path.gsub(%r{(_documentation|_tutorials|_use_cases)/#{I18n.default_locale}/}, '')
        ).dirname.to_s
      end
    end

    def product
      @product ||= begin
        products = YAML.safe_load(File.open("#{Rails.configuration.docs_base_path}/config/products.yml"))
        product = products['products'].detect do |p|
          product_from_path.starts_with?(p['path']) || frontmatter['products']&.include?(p['path'])
        end

        raise ArgumentError, "Unable to match document with products list in config/products.yml for #{full_path}" unless product

        product
      end
    end

    def product_translation_frequency
      raise ArgumentError, "Expected a 'translation_frequency' attribute for #{product['name']} but none found" unless product['translation_frequency']

      product['translation_frequency']
    end
  end
end
