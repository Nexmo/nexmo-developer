# frozen_string_literal: true

module Nexmo
  module OAS
    module Renderer
      module Helpers
        module Render
          def find_template(views, name, engine, &block)
            Array(views).each do |v|
              super(v, name, engine, &block)
            end
          end

          def render(*args)
            if args.length > 2
              super
            else
              ApplicationController.renderer.new(request.env).render(*args)
            end
          end
        end
      end
    end
  end
end
