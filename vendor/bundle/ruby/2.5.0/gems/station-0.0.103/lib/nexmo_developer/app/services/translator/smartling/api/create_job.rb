module Translator
  module Smartling
    module API
      class CreateJob
        include Base

        def initialize(project_id:, locales:, due_date:, token:)
          @project_id = project_id
          @locales    = locales
          @due_date   = due_date
          @token      = token
        end

        def request_body
          {
            'jobName' => "ADP Translation Job: #{@locales.join(',')} - #{Time.current.to_date}",
            'targetLocaleIds' => @locales,
            'dueDate' => @due_date,
          }
        end

        def success?
          @response.code == '200'
        end

        def return_value
          @return_value ||= response_body['response']['data']['translationJobUid']
        end

        def uri
          @uri ||= URI("https://api.smartling.com/jobs-api/v3/projects/#{@project_id}/jobs")
        end

        def headers
          { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@token}" }
        end

        def to_s
          return_value
        end
      end
    end
  end
end
