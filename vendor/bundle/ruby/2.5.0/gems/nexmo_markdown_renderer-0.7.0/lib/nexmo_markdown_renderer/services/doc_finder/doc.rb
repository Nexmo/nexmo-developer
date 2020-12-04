module Nexmo
  module Markdown
    class DocFinder::Doc
      attr_reader :path, :available_languages

      def initialize(path:, available_languages:)
        @path                = path
        @available_languages = available_languages
      end
    end
  end
end
