module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class Run
          include OcticonsHelper
          include Renderable

          def initialize(config, snippet)
            @config  = config
            @snippet = snippet
          end

          def run_command
            @run_command ||= begin
              if @config['run_command']
                @config['run_command'].gsub('{filename}', file_name)
              end
            end
          end

          def render
            renderer.run_command(run_command, file_name, @config['code']['source']).to_s
          end
        end
      end
    end
  end
end
