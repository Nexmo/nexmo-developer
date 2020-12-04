module Nexmo
  module Markdown
    module Pipelines
      module Smartling
        class Preprocessor < Banzai::Pipeline
          def initialize(_options = {})
            super(
              I18n::FrontmatterFilter,
            )
          end
        end
      end
    end
  end
end
