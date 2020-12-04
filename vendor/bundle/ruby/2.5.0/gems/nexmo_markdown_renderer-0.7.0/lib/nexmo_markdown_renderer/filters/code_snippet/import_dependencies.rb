module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class ImportDependencies
          include OcticonsHelper
          include Renderable

          attr_reader :config

          def initialize(config, snippet)
            @config  = config
            @snippet = snippet
          end

          def partial
            @partial ||= File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_import_dependencies.html.erb")
          end

          def highlighted_import_source
            @highlighted_import_source ||= ::Nexmo::Markdown::Utils.generate_code_block(
              language,
              @config,
              unindent
            )
          end

          def render
            return '' unless @config

            create_instructions = renderer.create_instructions(file_name).render_markdown
            ERB.new(partial).result(binding)
          end
        end
      end
    end
  end
end
