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
  class SmartlingUriTest < Test::Unit::TestCase

    def test_base
      uri = Smartling::Uri.new('http://hello.wo/')
      assert_equal('http://hello.wo/', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/', 'foo/bar')
      assert_equal('http://hello.wo/foo/bar', uri.to_s)
    end

    def test_params
      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => 'x'}
      assert_equal('http://hello.wo/?foo=x', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => 18}
      assert_equal('http://hello.wo/?foo=18', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => true}
      assert_equal('http://hello.wo/?foo=true', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => Time.utc(2012, 04, 05, 11, 19, 59)}
      assert_equal('http://hello.wo/?foo=2012-04-05T11:19:59Z', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => Time.utc(2012, 04, 05, 11, 49, 17).localtime}
      assert_equal('http://hello.wo/?foo=2012-04-05T11:49:17Z', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => ['hello']}
      assert_equal('http://hello.wo/?foo[]=hello', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => ['hello', 'world']}
      assert_equal('http://hello.wo/?foo[]=hello&foo[]=world', uri.to_s)

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => ['hello', 'world', 'of', Time.utc(2012)]}
      assert_equal('http://hello.wo/?foo[]=hello&foo[]=world&foo[]=of&foo[]=2012-01-01T00:00:00Z', uri.to_s)
    end

    def test_require
      uri = Smartling::Uri.new('http://hello.wo/')
      uri.require(:foo, :bar)
      assert_raise ArgumentError do uri.to_s end

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => 'x', :bar => 'y'}
      uri.require(:foo, :bar)
      assert_nothing_raised do uri.to_s end

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:foo => 'x', :baz => 'z'}
      uri.require(:foo, :bar)
      assert_raise ArgumentError do uri.to_s end

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.params = {:bar => 'y', :baz => 'z', :foo => 'x'}
      uri.require(:foo, :baz)
      assert_nothing_raised do uri.to_s end

      uri = Smartling::Uri.new('http://hello.wo/')
      uri.require()
      assert_nothing_raised do uri.to_s end
      assert_equal('http://hello.wo/', uri.to_s)
    end

    def test_encode
        uri = Smartling::Uri.new('http://hello.wo/')
        uri.params = {:foo => ['hello & world!']}
        assert_equal('http://hello.wo/?foo[]=hello%20%26%20world%21', uri.to_s)
    end

  end
end
