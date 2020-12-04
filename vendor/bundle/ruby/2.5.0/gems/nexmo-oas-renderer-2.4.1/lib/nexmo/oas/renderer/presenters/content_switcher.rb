# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class ContentSwitcher
          def initialize(format:, label:, theme_light:, force_type: nil)
            @format = format
            @panels = []
            @label = label
            @force_type = force_type
            @theme_light = theme_light
          end

          def add_content(title:, content:, tab_id:, active:)
            @panels.push({
                             'title' => title,
                             'content' => content,
                             'x-tab-id' => tab_id,
                             'active' => active,
                         })
          end

          def render
            type = 'tabs'
            type = 'dropdown' if @panels.length >= 8

            type = @force_type if @force_type

            [:"open_api/content_switcher/_#{type}", locals: {
                panels: @panels,
                format: @format,
                label: @label,
                switcher: self,
                theme_light: @theme_light,
            }]
          end

          def id
            @id ||= "s-#{SecureRandom.hex}"
          end
        end
      end
    end
  end
end
