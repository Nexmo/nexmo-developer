module Translator
  module Smartling
    module API
      class DownloadFile
        include Base

        def initialize(project_id:, locale_id:, file_uri:, token:)
          @project_id   = project_id
          @locale_id    = locale_id
          @file_uri     = file_uri
          @token        = token
        end

        def build_request
          Net::HTTP::Get.new(uri, headers)
        end

        def uri
          @uri ||= begin
            uri = URI("https://api.smartling.com/files-api/v2/projects/#{@project_id}/locales/#{@locale_id}/file")
            uri.query = URI.encode_www_form({ 'fileUri' => @file_uri, 'retrievalType' => 'published' })
            uri
          end
        end

        def headers
          { 'Authorization' => "Bearer #{@token}", 'Content-Type' => 'application/json' }
        end

        def success?
          @response.code == '200'
        end

        def return_value
          @return_value ||= @response.body
        end

        def to_s
          "#{@file_uri} => #{@locale_id}"
        end
      end
    end
  end
end
