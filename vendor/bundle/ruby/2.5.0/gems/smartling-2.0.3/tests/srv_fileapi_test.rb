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
require 'iconv'

module SmartlingTests
  class SmartlingFileApiTest < Test::Unit::TestCase

    TEST_FILE_YAML = 'tests/upload.yaml'
    TEST_FILE_UTF16 = 'tests/utf16.yaml'

    def setup
      @config = SmartlingTests.server_config
      @log = SmartlingTests.logger
    end

    def yaml_file(encoding = nil)
      data = <<-EOL
hello: world
we have: cookies
      EOL
      data = Iconv.conv(encoding, 'US-ASCII', data) if encoding
      f = Tempfile.new('smartling_tests')
      f.write(data)
      f.flush
      f.pos = 0
      return f
    end

    def test_1_list
      @log.debug '<- FileAPI:list'
      sl = Smartling::File.new(@config)
      res = nil
      assert_nothing_raised do res = sl.list end
      @log.debug res.inspect
    end

    def test_2_upload
      @log.debug '<- FileAPI:upload'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.upload(yaml_file, TEST_FILE_YAML, 'YAML')
      end
      @log.debug res.inspect
    end

    def test_2_1_upload
      @log.debug '<- FileAPI:upload'
      sl = Smartling::File.new(@config)

      res = nil
      assert_nothing_raised do
        res = sl.upload(yaml_file.path, TEST_FILE_YAML, 'YAML')
      end
      @log.debug res.inspect
    end

    def test_3_status
      @log.debug '<- FileAPI:status'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.status_all(TEST_FILE_YAML)
      end
      @log.debug res.inspect
    end

    def test_4_download_en
      @log.debug '-> FileAPI:download EN'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.download_translated(TEST_FILE_YAML, 'en-US')
      end
      @log.debug res.inspect
    end

    def test_5_download_ru
      @log.debug '-> FileAPI:download FR'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.download_translated(TEST_FILE_YAML, 'fr-FR')
      end
      @log.debug res.inspect
    end

    def test_6_utf16
      @log.debug '<- FileAPI UTF-16 upload'
      sl = Smartling::File.new(@config)

      file = yaml_file('UTF-16')
      data = file.read
      file.pos = 0

      res = nil
      assert_nothing_raised do
        res = sl.upload(file, TEST_FILE_UTF16, 'YAML')
      end
      @log.debug res.inspect

      @log.debug '-> FileAPI UTF-16 download EN'
      assert_nothing_raised do
        res = sl.download(TEST_FILE_UTF16)
      end
      @log.debug res.inspect

      @log.debug '-> FileAPI UTF-16 download FR'
      assert_nothing_raised do
        res = sl.download_translated(TEST_FILE_UTF16, 'fr-FR')
      end
      @log.debug res.inspect
    end

    def test_7_filter
      @log.debug '-> FileAPI full filter test'
      sl = Smartling::File.new(@config)
      res = nil
      assert_nothing_raised do
        res = sl.list(:uriMask => '%.yaml', :fileTypes => [:ios, :yaml],
              :lastUploadedAfter => Time.now - 3600, :lastUploadedBefore => Time.now + 24*3600,
              :offset => 0, :limit => 2)
      end
      @log.debug res.inspect
    end

    def test_8_rename
      @log.debug '-> FileAPI rename file'
      sl = Smartling::File.new(@config)
      res = nil
      assert_nothing_raised do
        res = sl.rename(TEST_FILE_YAML, 'foo/foo/foo')
        res = sl.rename('foo/foo/foo', TEST_FILE_YAML)
      end
      @log.debug res.inspect
    end

    def test_9_callbackurl
      @log.debug '-> FileAPI upload with callback URL'
      sl = Smartling::File.new(@config)
      res = nil
      assert_nothing_raised do
        res = sl.upload(yaml_file, TEST_FILE_YAML, 'YAML', :callbackUrl => 'http://google.com/?q=hello')
      end
      @log.debug res.inspect
    end

    def test_99_delete
      # NOTE: might break the tests following this and uploading with the same name
      # until server actually deletes the file.
      @log.debug '<- FileAPI:delete'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.delete(TEST_FILE_YAML)
      end
      @log.debug res.inspect
    end

  end
end

