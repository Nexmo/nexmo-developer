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

require 'rubygems'
require 'smartling'

def print_msg(msg)
  puts
  puts msg
end

# change these values to use those found on the Project Settings -> API page in dashboard
USER_ID = 'USERID'
USER_SECRET = 'USERSECRET'
PROJECT_ID = 'PROJECTID' 

print_msg "Smartling Ruby client #{Smartling::VERSION}"


# Initialize client to use File API on Production
sl = Smartling::File.new(:userId => USER_ID, :userSecret => USER_SECRET, :projectId => PROJECT_ID)

# Basic usage

# begin
print_msg 'Listing all project files...'
res = sl.list
p res
# rescue
# end

file = 'data.yaml' # your data file
file_uri = 'my_files/data.yaml' # unique identifier given to the uploaded file
file_type = 'YAML' # file type

# begin
print_msg "Uploading file '#{file}' using file URI '#{file_uri}' and file type '#{file_type}'..."
res = sl.upload(file, file_uri, file_type)
p res
# rescue
# end

# begin
print_msg 'Listing all project files...'
res = sl.list
p res
# rescue
# end

lang = 'fr-FR' # any language that exists in your project
state = 'PUBLISHED' # state at which imported strings are imported as

# begin
print_msg "Getting status for file URI '#{file_uri}' and language '#{lang}'..."
res = sl.status(file_uri, lang)
p res
# rescue
# end

# begin
print_msg "Importing translation file '#{file}' using file URI '#{file_uri}' and file type '#{file_type}' and language '#{lang}' as '#{state}'..." 
res = sl.import(lang, file, file_uri, file_type, state)
# rescue
# end

# begin
print_msg "Downloading translations for file URI '#{file_uri}' and language '#{lang}'..."
data = sl.download_translated(file_uri, lang)
puts data
# rescue
# end

new_file_uri = 'my_files/newdata.yaml' # new uri to uniquely identify the previously uploaded file

# begin
print_msg "Renaming file from '#{file_uri}' to '#{new_file_uri}'..."
sl.rename(file_uri, new_file_uri)
# rescue
# end

# begin
print_msg "Deleting file '#{new_file_uri}'..."
sl.delete(new_file_uri)
# rescue
# end

# Extended parameters
# begin
print_msg 'Uploading file with callback URL provided...'
res = sl.upload(file, 'name.yaml', 'YAML', :callbackUrl => 'http://yourdomain.com/someservice')
p res
# rescue
# end

# begin
print_msg 'Uploading file with approved flag provided...'
res = sl.upload(file, 'name.yaml', 'YAML', :authorize => true)
p res
# rescue
# end

# begin
print_msg 'Listing files using URI mask filter...'
res = sl.list(:uriMask => '%.yaml')
p res
# rescue
# end

# begin
print_msg 'Listing files using file type filter...'
res = sl.list(:fileTypes => ['yaml', 'ios'])
p res
# rescue
# end

# begin
print_msg 'Listing paginated files...'
page, size = 2, 10
res = sl.list(:offset => (page - 1) * size, :limit => size)
p res
# rescue
# end

# begin
print_msg 'Listing files uploaded after a certain date...'
res = sl.list(:lastUploadedAfter => Time.utc(2016, 10, 30))
p res
# rescue
# end

# begin
print_msg 'Listing files uploaded between a date range...'
res = sl.list(:lastUploadedAfter => Time.utc(2016, 10, 30), :lastUploadedBefore => Time.utc(2016, 11, 10))
p res
# rescue
# end

# begin
print_msg 'Listing files while combining multiple parameters...'
res = sl.list(:uriMask => '%.yaml', :fileTypes => [:ios, :yaml],
              :lastUploadedAfter => Time.now - 3600, :lastUploadedBefore => Time.now + 24*3600,
              :offset => 0, :limit => 2)
p res
# rescue
# end
