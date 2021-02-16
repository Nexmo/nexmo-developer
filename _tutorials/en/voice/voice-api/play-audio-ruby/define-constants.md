---
title: Define Constant Variables
description: Define constant variables for a Vonage Ruby Voice application to stream audio
---

# Define Constant Variables

The Vonage Voice API sends back call information to the webhook addresses we provided in the Vonage Voice Application in the API Dashboard. To receive that data we need an externally accessible URL. This tutorial uses ngrok to provide an externally available URL. For more information on setting up ngrok, follow this tutorial [here](https://developer.nexmo.com/tools/ngrok).

After initializing the Vonage Ruby SDK client in the `server.rb` file, add the following two constant variables, making sure to supply your ngrok URL in the `BASE_URL` constant definition:

```ruby
BASE_URL = 
AUDIO_URL = 'https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3'
```