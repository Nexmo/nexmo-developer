#!/usr/bin/ruby
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

$:.unshift File.expand_path('../', __FILE__)
require 'test_helper'

module SmartlingTests
  class StubResponse
    attr_accessor :code, :body
  end

  class SmartlingApiTest < Test::Unit::TestCase

    def stub_response(code, body)
      response = StubResponse.new()
      response.code = code
      response.body = body
      return response
    end

    def test_endpoints
      base = 'https://api.smartling.com/'
      sb = 'https://api.test.smartling.net/'

      sl = Smartling::Api.new()
      assert_equal(base, sl.baseUrl)

      sl = Smartling::Api.new(:baseUrl => base)
      assert_equal(base, sl.baseUrl)

      sl = Smartling::Api.new(:baseUrl => sb)
      assert_equal(sb, sl.baseUrl)

      sl = Smartling::Api.new(:baseUrl => 'custom')
      assert_equal('custom', sl.baseUrl)
    end

    def test_response_format
      sl = Smartling::Api.new()

      res = stub_response(200, '{"response":{"code":"SUCCESS", "data":"foo"}}')
      assert_equal('foo', sl.process(res))

      res = stub_response(200, '{"response":{"code":"SUCCESS", "data":null}}')
      res = sl.process(res)
      assert(res.nil?)

    end

    def test_error_response
      sl = Smartling::Api.new()

      res = stub_response(200, '{"response":{"code":"SUCCESS", "data":"foo"}}')
      assert_equal('foo', sl.process(res))

      res = stub_response(200, '{"response":{"code":"ERROR", "errors":[]}}')
      assert_raise RuntimeError do sl.process(res) end

      res = stub_response(500, '{"response":{"code":"ERROR", "errors":[]}}')
      assert_raise RuntimeError do sl.process(res) end

      res = stub_response(500, '{"response":{"code":"ERROR"}}')
      assert_raise RuntimeError do sl.process(res) end

      res = stub_response(500, '{"response":null}')
      assert_raise RuntimeError do sl.process(res) end

      res = stub_response(500, '{}')
      assert_raise RuntimeError do sl.process(res) end

      res = stub_response(200, '{}')
      assert_raise RuntimeError do sl.process(res) end
    end

  end
end
