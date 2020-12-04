# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class ResponseFormat
          MAPPINGS = {
            'application/json' => 'JSON',
            'application/xml' => 'XML',
            'text/xml' => 'XML',
          }.freeze

          def self.to_dropdown(formats)
            MAPPINGS.slice(*formats)
          end

          def initialize(responses)
            @responses = responses
          end

          def extract
            @extract ||= @responses.flat_map(&:formats).uniq
          end
        end
      end
    end
  end
end
