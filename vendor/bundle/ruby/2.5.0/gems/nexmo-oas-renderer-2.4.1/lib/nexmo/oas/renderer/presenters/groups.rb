# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Presenters
        class Groups
          def initialize(definition)
            @definition = definition
          end

          def groups
            tags = @definition.raw['tags']
            # For now we only use the first tag in the list as an equivalent for the old x-group functionality
            @groups = @definition.endpoints.group_by do |endpoint|
              next nil unless tags

              endpoint.raw['tags']&.first
            end

            # We want to use the order in which the tags are defined in the definition, so iterate over the tags
            # and store the index against the tag name. We'll use this later for sorting
            ordering = {}
            tags&.each_with_index do |tag, index|
              ordering[tag['name'].capitalize] = index
            end

            # Sort by the order in which they're defined in the definition
            @groups = @groups.sort_by do |name, _|
              next -1 if name.nil?

              ordering[name.capitalize] || 999
            end
          end
        end
      end
    end
  end
end
