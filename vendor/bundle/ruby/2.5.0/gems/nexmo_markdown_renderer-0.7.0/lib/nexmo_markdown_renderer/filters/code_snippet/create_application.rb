module Nexmo
  module Markdown
    module Filters
      module CodeSnippet
        class CreateApplication
          include Renderable

          NGROK_URL   = 'http://demo.ngrok.io'.freeze
          EXAMPLE_URL = 'https://example.com'.freeze

          attr_reader :app

          def initialize(app)
            @app = app
          end

          def base_url
            @base_url ||= @app['disable_ngrok'] && EXAMPLE_URL || NGROK_URL
          end

          def name
            @name ||= @app['name'] || 'ExampleProject'
          end

          def type
            # We should remove this default once we're sure that all Code Snippets
            # have a type set e.g audit
            @type ||= @app.fetch('type', 'voice')
          end

          def event_url
            @event_url ||= @app.fetch('event_url', "#{base_url}/webhooks/events")
          end

          def answer_url
            @answer_url ||= @app.fetch('answer_url', "#{base_url}/webhooks/answer")
          end

          def partial
            @partial ||= begin
                           case type
                           when 'voice', 'rtc'
                             File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_application_#{type}.html.erb")
                           when 'messages', 'dispatch'
                             File.read("#{GEM_ROOT}/lib/nexmo_markdown_renderer/views/code_snippets/_application_messages_dispatch.html.erb")
                           else
                             raise "Invalid application type when creating code snippet: '#{type}'"
                           end
                         end
          end

          def render
            return '' unless @app

            ERB.new(partial).result(binding)
          end
        end
      end
    end
  end
end
