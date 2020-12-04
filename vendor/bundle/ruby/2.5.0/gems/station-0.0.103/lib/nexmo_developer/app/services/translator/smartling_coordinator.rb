module Translator
  class SmartlingCoordinator
    def self.call(attrs = {})
      new(attrs).call
    end

    def initialize(requests:, frequency:)
      @requests  = requests
      @frequency = frequency
    end

    def call
      # One Smartling Job per locale
      requests_by_locale.map do |locale, requests|
        job_id = create_job(locale)

        next unless job_id

        batch_id = create_batch(job_id, requests)

        next unless batch_id

        requests.map { |r| upload_file_to_batch(batch_id, r) }
      end
    end

    def requests_by_locale
      @requests_by_locale ||= @requests.group_by(&:locale)
    end

    def due_date
      @due_date ||= (Time.zone.now + @frequency.days).to_s(:iso8601)
    end

    def create_job(locale)
      Translator::Smartling::ApiRequestsGenerator.create_job(
        locales: [locale],
        due_date: due_date
      )
    end

    def create_batch(job_id, requests)
      Translator::Smartling::ApiRequestsGenerator.create_batch(
        job_id: job_id,
        requests: requests
      )
    end

    def upload_file_to_batch(batch_id, translation_request)
      Translator::Smartling::ApiRequestsGenerator.upload_file(
        batch_id: batch_id,
        translation_request: translation_request
      )
    end
  end
end
