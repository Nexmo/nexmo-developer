---
title:  Add a Receive Call Route
description:  Adds an inbound call route for playing streamed audio into a call

---

Add a Receive Call Route
========================

You will now provide an [answer webhook](/voice/voice-api/webhook-reference#answer-webhook) so that when you receive an inbound call on your virtual number, the Vonage API platform will notify you on that webhook via an HTTP request.

The webhook will return an [NCCO](/voice/voice-api/ncco-reference) to Vonage containing a single `stream` action, which will play the audio from the file located at the `STREAM_URL` into the call.

For testing purposes you will use the URL: `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

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

