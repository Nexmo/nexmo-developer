---
title:  Add Voicemail Answer Route
description:  Add an answer route to start the voicemail

---

Add Voicemail Answer Route
==========================

Add a route to your `VoiceController` to handle the inbound call. This will be located at `/webhooks/answer` and will return a [NCCO](https://developer.nexmo.com/voice/voice-api/ncco-reference) with a `record` action, which instructs Vonage to start recording the call.

You must also specify the URL of another webhook - `/webhooks/recording` - which Vonage will make a request to when the recording is ready for download. You will code this webhook in the next step.

```csharp
[HttpGet("/webhooks/answer")]
public string Answer()
{
    var talkAction = new TalkAction
    {
        Text = "Hello, you have reached Steve's number," +
        " he cannot come to the phone right now. " +
        "Please leave a message after the tone."
    };
    var recordAction = new RecordAction
    {
        EndOnSilence = "3",
        BeepStart = "true",
        EventUrl = new[] { $"{Request.Scheme}://{Request.Host}/webhooks/recording" },
        EventMethod = "POST"
    };

    var ncco = new Ncco(talkAction, recordAction);
    return ncco.ToString();
}
```

