---
title: Ruby
language: ruby
menu_weight: 1
---

Install Sinatra by typing: `gem install sinatra`

The code below handles the incoming SMS messages.

```ruby
require 'sinatra'

get '/incoming-sms' do
  puts params['text']
  puts params['messageId']
  puts params['to']
  # do something interesting with this data...
end
```

Store this as `app.rb` and run it locally using:

```
$ ruby app.rb
```
