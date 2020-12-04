# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Helpers
        module Summary
          def normalize_summary_title(summary, operation_id)
            # return summary early if provided
            return summary unless summary.nil?

            # If the operation ID is camelCase,
            if operation_id.match?(/^[a-zA-Z]\w+(?:[A-Z]\w+){1,}/x)
              # Use the rails `.underscore` method to convert someString to some_string
              operation_id = operation_id.underscore
            end

            # Replace snake_case and kebab-case with spaces and titelize the string
            operation_id = operation_id.gsub(/(_|-)/, ' ').titleize

            # Some terms need to be capitalised all the time
            uppercase_array = %w[SMS DTMF]
            operation_id.split(' ').map do |c|
              next c.upcase if uppercase_array.include?(c.upcase)

              c
            end.join(' ')
          end
        end
      end
    end
  end
end
