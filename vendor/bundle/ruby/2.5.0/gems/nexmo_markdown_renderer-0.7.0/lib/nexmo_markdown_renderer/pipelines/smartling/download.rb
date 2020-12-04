module Nexmo
  module Markdown
    module Pipelines
      module Smartling
        class Download < Banzai::Pipeline
          def initialize(_options = {})
            super(
              I18n::Smartling::FrontmatterFilter,
              I18n::Smartling::EscapeFilter,
              I18n::Smartling::CodeBlockFilter
            )
          end
        end
      end
    end
  end
end
