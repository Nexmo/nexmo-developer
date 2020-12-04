module Translator
  module Smartling
    module API
      class CreateBatch
        include Base

        def initialize(project_id:, job_id:, token:, requests:)
          @project_id = project_id
          @job_id     = job_id
          @token      = token
          @requests   = requests
        end

        def request_body
          {
            'translationJobUid' => @job_id,
            'authorize' => true,
            'fileUris' => file_uris,
          }
        end

        def file_uris
          @requests.map(&:file_uri)
        end

        def uri
          @uri ||= URI("https://api.smartling.com/job-batches-api/v2/projects/#{@project_id}/batches")
        end

        def success?
          @response.code == '200'
        end

        def return_value
          @return_value ||= response_body['response']['data']['batchUid']
        end

        def to_s
          return_value
        end

        def headers
          { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}" }
        end
      end
    end
  end
end
