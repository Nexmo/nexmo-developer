---
title:  Add Recording Route
description:  Handle Recording event from Vonage

---

Add Recording Route
===================

After the call has finished recording, Vonage will send a request to the webhook URL you configured in the `record` action in your NCCO. This request will contain the URL from which you can download the audio file.

In this tutorial, you'll use the `GetRecording` API to download the recording to your local machine:

```csharp
[HttpPost("/webhooks/recording")]
public async Task<IActionResult> Recording()
{
    var appId = _config["APPLICATION_ID"];
    var privateKeyPath = _config["PRIVATE_KEY_PATH"];
    var credentials = Credentials.FromAppIdAndPrivateKeyPath(appId, privateKeyPath);
    var voiceClient = new VoiceClient(credentials);
    var record = await Vonage.Utility.WebhookParser.ParseWebhookAsync<Record>(Request.Body, Request.ContentType);
    var recording = await voiceClient.GetRecordingAsync(record.RecordingUrl);
    await System.IO.File.WriteAllBytesAsync("your_recording.mp3", recording.ResultStream);
    return StatusCode(204);
}
```

