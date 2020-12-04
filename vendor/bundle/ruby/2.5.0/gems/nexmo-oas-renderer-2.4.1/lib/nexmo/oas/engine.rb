# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      class Engine < ::Rails::Engine
        config.assets.paths << "#{config.root}/lib/nexmo/oas/renderer/public/assets"
      end
    end
  end
end
