module Translator
  class TranslatorCoordinator
    attr_reader :paths

    def initialize(paths:, frequency:)
      @paths     = paths
      @frequency = frequency
    end

    def requests
      @requests ||= @paths.map do |path|
        Translator::FileTranslator.new(path).translation_requests
      end.flatten
    end

    def requests_by_frequency
      @requests_by_frequency ||= requests.group_by(&:frequency)
    end

    def create_smartling_jobs!
      Translator::SmartlingCoordinator.call(
        requests: requests_by_frequency.fetch(@frequency, []),
        frequency: @frequency
      )
    end

    def download_smartling_files!
      Translator::SmartlingDownloader.call(
        paths: @paths
      )
    end
  end
end
