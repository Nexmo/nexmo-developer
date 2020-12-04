# frozen_string_literal: true

require_relative './response_tab/link'
require_relative './response_tab/panel'

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class ResponseTabs
          attr_reader :format, :switcher

          def initialize(format, response, content, endpoint, theme_light: nil)
            @format   = format
            @response = response
            @content  = content
            @endpoint = endpoint
            @theme_light = theme_light
            @switcher ||= @response.schema(@format)['x-switcher']
          end

          def tab_links
            @tab_links ||= @response.split_schemas(@format).map.with_index do |schema, index|
              schema = handle_all_of(schema)
              ResponseTab::Link.new(
                index: index,
                schema: schema
              )
            end
          end

          def tab_panels
            @tab_panels ||= @response.split_schemas(@format).map.with_index do |schema, index|
              schema = handle_all_of(schema)
              ResponseTab::Panel.new(
                schema: schema,
                index: index,
                format: @format,
                content: @content,
                endpoint: @endpoint,
                theme_light: @theme_light
              )
            end
          end

          def handle_all_of(schema)
            if schema['allOf']
              schema['allOf'].each do |p|
                schema.deep_merge!(p)
              end
              schema.delete('allOf')
            end
            schema
          end
        end
      end
    end
  end
end
