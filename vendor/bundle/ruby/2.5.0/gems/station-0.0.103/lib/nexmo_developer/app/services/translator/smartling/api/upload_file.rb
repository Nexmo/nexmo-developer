module Translator
  module Smartling
    module API
      class UploadFile
        include Base

        def initialize(translation_request:, project_id:, batch_id:, token:)
          @translation_request = translation_request
          @project_id          = project_id
          @batch_id            = batch_id
          @token               = token
        end

        def build_request
          request = Net::HTTP::Post.new(uri.path, headers)
          request.set_form form_data, 'multipart/form-data'
          request
        end

        def form_data
          [
            ['file', File.open(file)],
            ['fileUri', @translation_request.file_uri],
            ['fileType', 'markdown'],
            ['localeIdsToAuthorize[]', @translation_request.locale],
          ]
        end

        def success?
          @response.code == '202'
        end

        def uri
          @uri ||= URI("https://api.smartling.com/jobs-batch-api/v2/projects/#{@project_id}/batches/#{@batch_id}/file")
        end

        def return_value
          @return_value ||= @translation_request.file_uri
        end

        def to_s
          return_value
        end

        def headers
          { 'Authorization' => "Bearer #{@token}" }
        end

        def cleanup
          file.unlink
        end

        def file
          @file ||= begin
            file = Tempfile.new
            file.write(
              Nexmo::Markdown::Pipelines::Smartling::Preprocessor.new.call(
                File.read(@translation_request.file_path)
              )
            )
            file.rewind
            file.close
            file
          end
        end
      end
    end
  end
end
