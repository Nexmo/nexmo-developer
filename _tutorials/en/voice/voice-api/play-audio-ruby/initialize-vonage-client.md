---
title: Initialize Vonage Client
description: Initialize Vonage client for a Vonage Ruby Voice application to stream audio
---

# Initialize Vonage Client

After the `require` statements at the top of the `server.rb` file, initialize a new Vonage Ruby client using the credentials you provided in the `.env` file created earlier:

```ruby
client = Vonage::Client.new(
  api_key: ENV['VONAGE_API_KEY'],
  api_secret: ENV['VONAGE_API_SECRET'],
  application_id: ENV['VONAGE_APPLICATION_ID'],
  private_key: File.read(ENV['VONAGE_APPLICATION_PRIVATE_KEY_PATH'])
)
```