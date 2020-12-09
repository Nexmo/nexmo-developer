---
title:  Add Make Call Action
description:  Add an Action to the Voice Controller to place a call with streamed audio

---

Add Make Call Action
--------------------

In the Voice controller add a new HTTP `POST` route. You will use this to make an outgoing call with a NCCO [`stream` action](/voice/voice-api/ncco-reference#stream). This action will play the audio file located at the `STREAM_URL` into the call.

This will place a call, and pass a single action into that call which will play the audio file located at the `STREAM_URL` into the call.

For testing purposes use `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

Add the following code to the `VoiceController` class:

```csharp
[HttpPost]
public IActionResult MakePhoneCall(string toNumber, string fromNumber)
{
    const string STREAM_URL = "https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3";
    var appId = _config["APPLICATION_ID"];
    var privateKeyPath = _config["PRIVATE_KEY_PATH"];

    var streamAction = new StreamAction{ StreamUrl = new string[] { STREAM_URL }};
    var ncco = new Ncco(streamAction);

    var toEndpoint = new PhoneEndpoint{Number=toNumber};
    var fromEndpoint = new PhoneEndpoint{Number=fromNumber};

    var credentials = Credentials.FromAppIdAndPrivateKeyPath(appId, privateKeyPath);
    var client = new VoiceClient(credentials);
    var callRequest = new CallCommand { To = new []{toEndpoint}, From = fromEndpoint, Ncco= ncco};
    var call = client.CreateCall(callRequest);
    ViewBag.Uuid = call.Uuid;
    return View("Index");
}
```

