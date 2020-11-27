---
title: Ruby
language: ruby 
---

```ruby
require 'nexmo'

client = Vonage::Client.new(api_key: API_KEY, api_secret: API_SECRET)
client.numbers.search(country: 'FR')
client.numbers.search(country: 'BR', features: "SMS")
client.numbers.search(country: 'FR', pattern: "007", search_pattern: 1)
```
