# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        module ResponseTab
          class Link
            attr_reader :index

            def initialize(index:, schema:)
              @index  = index
              @schema = schema
            end

            def css_classes
              classes = ['tab-sync Vlt-tabs__link']
              classes << 'Vlt-tabs__link_active' if @index.zero?
              classes.join(' ')
            end

            def data_tab_link
              return nil unless @schema['x-tab-id']

              @schema['x-tab-id']
            end

            def content
              @schema['description'] || "Response #{@index + 1}"
            end
          end
        end
      end
    end
  end
end
