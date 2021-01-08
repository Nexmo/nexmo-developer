---
title:  添加语音信箱应答路由
description:  添加语音信箱应答路由以启动语音信箱

---

添加语音信箱应答路由
==========

向您的 `VoiceController` 添加路由以处理呼入电话。它位于 `/webhooks/answer`，将返回 [NCCO](https://developer.nexmo.com/voice/voice-api/ncco-reference)，其中包含用于提示 Vonage 开始对通话录音的 `record` 操作。

您还必须指定另一个 Webhook 的 URL - `/webhooks/recording` - 录音可供下载时，Vonage 将向其发出请求。您将在下一步中对此 Webhook 进行编码。

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

