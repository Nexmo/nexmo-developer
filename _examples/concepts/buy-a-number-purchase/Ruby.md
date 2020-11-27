---
title: Ruby
language: ruby
---

```ruby
require 'nexmo'

client = Vonage::Client.new(api_key: API_KEY, api_secret: API_SECRET)
client.numbers.buy(country: "GB", msisdn: "447700900000")
```
