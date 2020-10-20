---
title: Add a Receive Call Route
description: Adds an inbound call route for playing streamed audio into a call
---

# Add a Receive Call Route

We will now add an inbound call webhook URL, when we receive a call on our Virtual Number, Vonage will send us a webhook telling us that it happened. We will return an [NCCO](https://developer.nexmo.com/voice/voice-api/ncco-reference) to Vonage containing a single action, which will play the audio from the file located at the `STREAM_URL` into the call.

For testing purposes we will use the URL: `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

Add the following code to the `VoiceController` class

```csharp
[HttpGet("/webhooks/answer")]
public string Answer()
{
    const string STREAM_URL = "https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3";
    var streamAction = new StreamAction{
        StreamUrl = new string[]
        {
            STREAM_URL
        }
    };
    var ncco = new Ncco(streamAction);
    return ncco.ToString();
}
```
