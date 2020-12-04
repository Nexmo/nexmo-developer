# frozen_string_literal: true

module OasParser
  class Webhook < Path
    def name
      path
    end
  end
end
