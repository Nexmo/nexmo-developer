module Translator
  module Smartling
    module API
      class FileUris
        include Base

        def initialize(project_id:, token:)
          @project_id   = project_id
          @token        = token
        end

        def build_request
          Net::HTTP::Get.new(uri, headers)
        end

        def headers
          { 'Authorization' => "Bearer #{@token}", 'Content-Type' => 'application/json' }
        end

        def uri
          @uri ||= begin
            uri = URI("https://api.smartling.com/published-files-api/v2/projects/#{@project_id}/files/list/recently-published")
            uri.query = URI.encode_www_form({ 'publishedAfter' => format_date })
            uri
          end
        end

        def format_date
          DateTime.parse(1.week.ago.to_s).iso8601.to_s
        end

        def success?
          @response.code == '200'
        end

        def return_value
          @return_value ||= response_body['response']['data']['items'].map { |item| item['fileUri'] }
        end

        def to_s
          return_value.join("\n").prepend("\n")
        end
      end
    end
  end
end
