module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class InitializeDependencies
          include OcticonsHelper
          include Renderable

          def initialize(config, snippet)
            @config  = config
            @snippet = snippet
          end

          def partial
            @partial ||= File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_configure_client.html.erb")
          end

          def highlighted_client_source
            @highlighted_client_source ||= ::Nexmo::Markdown::Utils.generate_code_block(
              language,
              @config,
              unindent
            )
          end

          def render
            return '' unless @config

            create_instructions = if import_dependencies?
              renderer.add_instructions(file_name).render_markdown
            else
              renderer.create_instructions(file_name).render_markdown
            end

            ERB.new(partial).result(binding)
          end
        end
      end
    end
  end
end
