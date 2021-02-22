---
title: Create Routes
description: Create the HTTP routes for a Vonage Ruby Voice application to stream audio
---

# Create Routes

We will add three HTTP routes to the `server.rb` file, two `GET` routes and one `POST` route.

The first `GET` route will start a new phone call after it is accessed. The second `GET` route will welcome the recipient with a greeting. The `POST` route will send the streaming audio instructions to the Voice API once the call has been answered:

```ruby
get '/new' do
  response = client.voice.create(
    to: [{ type: 'phone', number: ENV['VONAGE_NUMBER'] }],
    from: { type: 'phone', number: ENV['TO_NUMBER'] },
    answer_url: ["#{BASE_URL}/answer"],
    event_url: ["#{BASE_URL}/event"]
  )

  puts response.inspect
end

get '/answer' do
  content_type :json
  [
    {
      :action => 'stream',
      :streamUrl => ['https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3'],
      :loop => 0
    }
  ].to_json
end

post '/event' do
  data = JSON.parse(request.body.read)
  response = client.voice.stream.start(data['uuid'], stream_url: [AUDIO_URL]) if data['status'] == 'answered'
  puts response.inspect
end
```
