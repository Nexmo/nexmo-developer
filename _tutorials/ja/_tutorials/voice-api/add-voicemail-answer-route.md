---
title:  ボイスメール応答ルートの追加
description:  応答ルートを追加してボイスメールを開始します

---

ボイスメール応答ルート
===========

着信通話を処理するためにルートを`VoiceController`に追加します。これは、`/webhooks/answer`に配置され、`record`アクションを持つ[NCCO](https://developer.nexmo.com/voice/voice-api/ncco-reference)を返します。このアクションで、Vonageに通話の録音を開始するように指示します。

別のWebhookである`/webhooks/recording`のURLも指定する必要があります。これは、録音がダウンロードできる状態になったときにVonageが要求します。次のステップでこのWebhookをコーディングします。

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

