---
title:  添加录音路由
description:  处理来自 Vonage 的录音事件

---

添加录音路由
======

该呼叫完成录音后，Vonage 将向您在 NCCO 的 `record` 操作中配置的 Webhook URL 发送请求。该请求将包含可供您下载音频文件的 URL。

在本教程中，您将使用 `GetRecording` API 将录音下载到本地计算机：

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

