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

$:.unshift File.expand_path('../../lib', __FILE__)
require 'rubygems'
require 'logger'
require 'smartling'
require 'test/unit'
require 'yaml'
require 'json'

class Hash
  def keysym!
    keys.each {|key|
      self[(key.to_sym rescue key) || key] = delete(key)
    }
    self
  end
end

module SmartlingTests
  CONFIG = 'tests/config'

  class << self

  def config
    return @config if @config
    return unless File.exists?(CONFIG)
    h = YAML.load_file(CONFIG)
    @config = h.keysym!
  end

  def server_config
    cfg = config() or raise 'Missing config file for server tests'
    h = cfg[:server]
    h.keysym!
  end

  def logger
    l = Logger.new($stderr)
    l.level = config[:loglevel]
    l.formatter = proc {|sev, dt, prg, msg|
      "#{sev}: #{msg}\n"
    }
    return l
  end

  end
end

