module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class Instructions
          include OcticonsHelper
          include Renderable

          attr_reader :config

          def initialize(config, snippet)
            @config  = config
            @snippet = snippet
          end

          def partial
            @partial ||= begin
              if @config['code_only']
                File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_code_only.html.erb")
              else
                File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_write_code.html.erb")
              end
            end
          end

          def highlighted_code_source
            @highlighted_code_source ||= ::Nexmo::Markdown::Utils.generate_code_block(
              language,
              @config['code'],
              unindent
            )
          end

          def source_url
            @source_url ||= ::Nexmo::Markdown::Utils.generate_source_url(@config['code'])
          end

          def render
            add_instructions = renderer.add_instructions(file_name).render_markdown
            ERB.new(partial).result(binding)
          end
        end
      end
    end
  end
end
