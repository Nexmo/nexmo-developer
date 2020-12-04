# frozen_string_literal: true

require 'oas_parser'

module OasParser
  class Path
    def servers
      raw['servers']
    end
  end

  class Endpoint
    def oauth?
      return false unless security

      security_schemes.each do |security_schema|
        return true if security_schema['bearerFormat'] == 'OAuth'
      end

      false
    end
  end
end
