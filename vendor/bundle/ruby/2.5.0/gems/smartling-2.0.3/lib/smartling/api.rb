# Copyright 2012 Smartling, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rest-client'
require 'multi_json'
require 'smartling/uri'
require 'oj'

module Smartling

  module Endpoints
    CURRENT = 'https://api.smartling.com/'
  end

  class Api
    EXPIRATION_OFFSET = 60
    attr_accessor :baseUrl, :prefix

    def initialize(args = {})
      @userId = args[:userId]
      @userSecret = args[:userSecret]
      @baseUrl = args[:baseUrl] || Endpoints::CURRENT
    end

    def uri(path, params1 = nil, params2 = nil)
      uri = Uri.new(@baseUrl, path)
      params = {}
      params.merge!(params1) if params1
      params.merge!(params2) if params2
      uri.params = params
      return uri
    end

    def check_response(res)
      return if res.code == 200
      format_api_error(res) 
      raise 'API_ERROR' 
    end

    def process(res)
      check_response(res)
      body = MultiJson.load(res.body)
      if body['response']
        body = body['response']
        if body['code'] == 'SUCCESS'
          return body['data']
        else
          format_api_error(res) 
          raise 'API_ERROR' 
        end
      end
      raise 'API_ERROR' 
      return nil
    end

    def format_api_error(res)
      begin
        body = MultiJson.load(res.body)
      rescue
      end

      if body && body['response']
        body = body['response'] 
        STDERR.puts "\e[31m#{body['code']}\e[0m"
        if body['errors']
          body['errors'].each do |e|
            STDERR.puts "\e[31m#{e['message']}\e[0m"
          end
        end
      end
    end

    def call(uri, method, auth, upload, download, params = nil)
      headers = {}
      headers[:Authorization] = token_header() if auth
      headers[:content_type] = :json unless upload
      headers[:accept] = :json unless download
      RestClient::Request.execute(:method => method, 
                                  :url => uri.to_s,
                                  :payload => params,
                                  :headers => headers)  {|res, _, _|
        if download
          check_response(res)
          res.body  
        else
          process(res)
        end
      }
    end

    def get(uri)
      call(uri, :get, true, false, false)
    end
    def get_raw(uri)
      call(uri, :get, true, false, true)
    end
    def post(uri, params = nil)
      call(uri, :post, true, false, false, MultiJson.dump(params))
    end
    def post_file(uri, params = nil)
      call(uri, :post, true, true, false, params)
    end
    def post_file_raw(uri, params = nil)
      call(uri, :post, true, true, true, params)
    end

    def log=(v)
      RestClient.log = v
    end
    def proxy=(v)
      RestClient.proxy = v
    end

    # auth

    def token_header()
      t = token()
      raise 'AUTH_ERROR' if t.nil?
      return "Bearer #{t}"
    end

    def process_auth(response) 
      now = Time.new.to_i
      @token = response['accessToken']
      @token_expiration = now + response['expiresIn'].to_i - EXPIRATION_OFFSET
      @refresh = response['refreshToken']
      @refresh_expiration = now + response['refreshExpiresIn'].to_i - EXPIRATION_OFFSET
    end

    # Authenticate - /auth-api/v2/authenticate (POST)
    def token()
      # Check if current token is still valid
      if @token
        now = Time.new.to_i
        if @token_expiration > now
          return @token
        elsif @refresh && @refresh_expiration > now
          return refresh()
        end
      end

      # Otherwise call authenticate endpoint
      uri = uri('auth-api/v2/authenticate', {}, {})
      RestClient.post(uri.to_s, MultiJson.dump({:userIdentifier => @userId, :userSecret => @userSecret}), {:content_type => :json, :accept => :json}) {|res, _, _|
        process_auth(process(res))
        return @token
      }
    end

    # Refresh Authentication - /auth-api/v2/authenticate/refresh (POST)
    def refresh()
      uri = uri('auth-api/v2/authenticate/refresh', {}, {})
      RestClient.post(uri.to_s, MultiJson.dump({:refreshToken => @refresh}), {:content_type => :json, :accept => :json}) {|res, _, _|
        process_auth(process(res))
        return @token
      }
    end

  end

end

