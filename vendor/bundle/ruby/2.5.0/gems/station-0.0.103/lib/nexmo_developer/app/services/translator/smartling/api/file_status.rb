module Translator
  module Smartling
    module API
      class FileStatus
        include Base

        def initialize(project_id:, file_uri:, token:)
          @project_id   = project_id
          @file_uri     = file_uri
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
            uri = URI("https://api.smartling.com/files-api/v2/projects/#{@project_id}/file/status")
            uri.query = URI.encode_www_form({ 'fileUri' => @file_uri })
            uri
          end
        end

        def success?
          @response.code == '200'
        end

        def return_value
          @return_value ||= response_body['response']['data']['items'].map { |item| item['localeId'] }
        end

        def to_s
          "#{@file_uri} => #{return_value}"
        end
      end
    end
  end
end
