module Translator
  class TranslationRequest
    attr_reader :locale, :frequency, :file_uri, :file_path

    def initialize(locale:, frequency:, file_uri:, file_path:)
      @locale    = locale
      @frequency = frequency
      @file_uri  = file_uri
      @file_path = file_path
    end
  end
end
