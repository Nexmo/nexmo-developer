module Translator
  module Smartling
    module API
      module Base
        def self.included(base)
          base.extend ClassMethods
        end

        def build_request
          request = Net::HTTP::Post.new(uri.path, headers)
          request.body = request_body.to_json
          request
        end

        def make_request!
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          @response = http.request(build_request)
        end

        def response_body
          @response_body ||= JSON.parse(@response.body)
        end

        def error
          "#{self.class} #{@response.code}: #{response_body['response']['errors'][0]['message']}"
        end

        def call
          make_request!

          raise error unless success?

          Rails.logger.info("#{self.class} : Success #{self}")
          return_value
        rescue StandardError => e
          Bugsnag.notify(e.message)
          Rails.logger.error(e.message)
          nil
        ensure
          cleanup
        end

        def cleanup; end

        module ClassMethods
          def call(attrs = {})
            new(attrs).call
          end
        end
      end
    end
  end
end
