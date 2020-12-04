module GreenhouseIo
  class JobBoard
    include HTTMultiParty
    include GreenhouseIo::API
    attr_accessor :api_token, :organization
    base_uri 'https://api.greenhouse.io/v1'

    def initialize(api_token = nil, default_options = {})
      @api_token = api_token || GreenhouseIo.configuration.api_token
      @organization = default_options.delete(:organization) || GreenhouseIo.configuration.organization
    end

    def offices(options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/offices")
    end

    def office(id, options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/office", query: { id: id })
    end

    def departments(options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/departments")
    end

    def department(id, options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/department", query: { id: id })
    end

    def jobs(options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/jobs", query: { content: options[:content] })
    end

    def job(id, options = {})
      get_from_job_board_api("/boards/#{ query_organization(options) }/embed/job", query: { id: id, questions: options[:questions] })
    end

    def apply_to_job(job_form_hash)
      post_to_job_board_api('/applications', { :body => job_form_hash, :basic_auth => basic_auth })
    end

    private

    def query_organization(options_hash)
      org = options_hash[:organization] || @organization
      org.nil? ? (raise GreenhouseIo::Error.new("organization can't be blank")) : org
    end

    def get_from_job_board_api(url, options = {})
      response = get_response(url, options)
      if response.code == 200
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end

    def post_to_job_board_api(url, options)
      response = post_response(url, options)
      if response.code == 200
        response.include?("success") ? parse_json(response) : raise(GreenhouseIo::Error.new(response["reason"]))
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end
  end
end
