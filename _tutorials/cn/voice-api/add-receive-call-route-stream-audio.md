---
title:  添加接收呼叫路由
description:  添加呼入电话路由，以在呼叫中播放流音频

---

添加接收呼叫路由
========

现在，您将提供[应答 Webhook](/voice/voice-api/webhook-reference#answer-webhook)，以便当您的虚拟号码收到呼入电话时，Vonage API 平台将通过 HTTP 请求在该 Webhook 上通知您。

Webhook 将向 Vonage 返回 [NCCO](/voice/voice-api/ncco-reference)，其中包含单个 `stream` 操作，该操作将在通话中播放位于 `STREAM_URL` 的文件中的音频。

出于测试目的，您将使用 URL： `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

将以下代码添加到 `VoiceController` 类

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

