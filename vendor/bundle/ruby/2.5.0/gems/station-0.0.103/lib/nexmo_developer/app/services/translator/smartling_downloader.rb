module Translator
  class SmartlingDownloader
    include ::Translator::Utils

    attr_reader :file_uris

    def self.call(attrs = {})
      new(attrs).call
    end

    def initialize(file_uris: nil)
      @file_uris = file_uris || file_uris_from_smartling
    end

    def call
      raise ArgumentError, "The 'file_uris' parameter cannot be empty" unless @file_uris

      @file_uris.map do |uri|
        locales = get_file_status(file_uri: uri)
        next unless locales

        locales.map { |locale| download_file(locale: locale, file_uri: uri) }
      end
    end

    def file_uris_from_smartling
      ::Translator::Smartling::ApiRequestsGenerator.file_uris
    end

    def get_file_status(file_uri:)
      ::Translator::Smartling::ApiRequestsGenerator.get_file_status(
        file_uri: file_uri
      )
    end

    def download_file(locale:, file_uri:)
      doc = ::Translator::Smartling::ApiRequestsGenerator.download_file(
        locale: locale,
        file_uri: file_uri
      )

      return unless doc

      save_file(doc, locale, file_uri)
    end

    def save_file(doc, locale, file_uri)
      locale = locale_without_region(locale.to_s)
      folder = storage_folder(file_uri, locale)
      FileUtils.mkdir_p(folder) unless File.exist?(folder)
      File.open(file_path(file_uri, locale), 'w+') do |file|
        file.binmode
        file.write(Nexmo::Markdown::Pipelines::Smartling::Download.call(doc))
      end
    end
  end
end
