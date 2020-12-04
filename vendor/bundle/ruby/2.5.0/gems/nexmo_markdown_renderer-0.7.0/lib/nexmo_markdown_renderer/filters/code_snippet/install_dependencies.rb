module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class InstallDependencies
          include Renderable

          def initialize(config, version, snippet)
            @config  = config
            @snippet = snippet
            @version = version
          end

          def partial
            @partial ||= File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_dependencies.html.erb")
          end

          def title
            @title ||= begin
              # The only valid dependency for curl examples is `JWT`
              if @config.map(&:upcase).include?('JWT')
                ::I18n.t('filters.generate_your_jwt')
              else
                ::I18n.t('filters.install_dependencies')
              end
            end
          end

          def render
            return '' unless @config

            deps = renderer.dependencies(@config, @version)
            ERB.new(partial).result(binding)
          end
        end
      end
    end
  end
end
