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

module Smartling
  class Uri
    attr_accessor :base,  :path, :params, :required

    def initialize(base, path = nil)
      @base = base
      @path = path
      @required = []
    end

    def require(*args)
      @required += args
      return self
    end

    def to_uri
      params = @params || {}
      required = @required || []
      params.delete_if {|k,v| v.nil? || v.to_s.size <= 0 }
      missing = required - params.keys
      raise ArgumentError, "Missing parameters: " + missing.inspect if missing.size > 0

      uri = URI.parse(@base)
      uri.merge!(@path) if @path
      if params.size > 0
        uri.query = format_query(params)
      end
      return uri
    end

    def to_s
      to_uri.to_s
    end

    def format_query(params)
    # TODO: UTF-8 encode keys and values
    # URI.encode_www_form(params)
      params.map {|k,v|
        if v.respond_to?(:to_ary)
          v.to_ary.map {|w|
            k.to_s + '[]=' + format_value(w)
          }.join('&')
        else
          k.to_s + '=' + format_value(v)
        end
      }.join('&')
    end

    def format_value(v)
      v.is_a?(Time) ? format_time(v) :
        CGI.escape(v.to_s).gsub('+', '%20')
    end

    def format_time(t)
      t.utc.iso8601
    end

  end
end
