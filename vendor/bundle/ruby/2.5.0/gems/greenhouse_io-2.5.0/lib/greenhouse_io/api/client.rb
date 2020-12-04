module GreenhouseIo
  class Client
    include HTTMultiParty
    include GreenhouseIo::API

    PERMITTED_OPTIONS = [:page, :per_page, :job_id]

    attr_accessor :api_token, :rate_limit, :rate_limit_remaining, :link
    base_uri 'https://harvest.greenhouse.io/v1'

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end

    def offices(id = nil, options = {})
      get_from_harvest_api "/offices#{path_id(id)}", options
    end

    def offers(id = nil, options = {})
      get_from_harvest_api "/offers#{path_id(id)}", options
    end

    def departments(id = nil, options = {})
      get_from_harvest_api "/departments#{path_id(id)}", options
    end

    def candidates(id = nil, options = {})
      get_from_harvest_api "/candidates#{path_id(id)}", options
    end

    def activity_feed(id, options = {})
      get_from_harvest_api "/candidates/#{id}/activity_feed", options
    end

    def create_candidate_note(candidate_id, note_hash, on_behalf_of)
      post_to_harvest_api(
        "/candidates/#{candidate_id}/activity_feed/notes",
        note_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def applications(id = nil, options = {})
      get_from_harvest_api "/applications#{path_id(id)}", options
    end

    def offers_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers", options
    end

    def current_offer_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers/current_offer", options
    end

    def scorecards(id, options = {})
      get_from_harvest_api "/applications/#{id}/scorecards", options
    end

    def all_scorecards(id = nil, options = {})
      get_from_harvest_api "/scorecards/#{id}", options
    end

    def scheduled_interviews(id, options = {})
      get_from_harvest_api "/applications/#{id}/scheduled_interviews", options
    end

    def jobs(id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}", options
    end

    def stages(id, options = {})
      get_from_harvest_api "/jobs/#{id}/stages", options
    end

    def job_post(id, options = {})
      get_from_harvest_api "/jobs/#{id}/job_post", options
    end

    def users(id = nil, options = {})
      get_from_harvest_api "/users#{path_id(id)}", options
    end

    def sources(id = nil, options = {})
      get_from_harvest_api "/sources#{path_id(id)}", options
    end

    private

    def path_id(id = nil)
      "/#{id}" unless id.nil?
    end

    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end

    def get_from_harvest_api(url, options = {})
      response = get_response(url, {
        :query => permitted_options(options), 
        :basic_auth => basic_auth
      })

      set_headers_info(response.headers)

      if response.code == 200
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end

    def post_to_harvest_api(url, body, headers)
      response = post_response(url, {
        :body => JSON.dump(body),
        :basic_auth => basic_auth,
        :headers => headers
      })

      set_headers_info(response.headers)

      if response.code == 200
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end

    def set_headers_info(headers)
      self.rate_limit = headers['x-ratelimit-limit'].to_i
      self.rate_limit_remaining = headers['x-ratelimit-remaining'].to_i
      self.link = headers['link'].to_s
    end
  end
end
