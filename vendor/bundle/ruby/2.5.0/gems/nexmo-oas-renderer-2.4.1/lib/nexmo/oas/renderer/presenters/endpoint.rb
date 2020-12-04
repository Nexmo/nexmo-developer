# frozen_string_literal: true

require_relative './response_format'

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class Endpoint
          def initialize(endpoint)
            @endpoint = endpoint
          end

          def formats
            @formats ||= ResponseFormat.new(@endpoint.responses).extract
          end
        end
      end
    end
  end
end
