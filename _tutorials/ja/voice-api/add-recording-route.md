---
title:  録音ルートを追加
description:  Vonageからの録音イベントを処理します

---

録音ルートを追加
========

通話の録音が完了すると、VonageはNCCOの`record`アクションで設定したWebhook URLに要求を送信します。このリクエストには、オーディオファイルをダウンロードできるURLが含まれます。

このチュートリアルでは、`GetRecording` APIを使用して録音をローカルマシンにダウンロードします：

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

