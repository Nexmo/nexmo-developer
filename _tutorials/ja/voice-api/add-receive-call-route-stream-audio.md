---
title:  通話受信ルートの追加
description:  ストリーミングオーディオを通話に再生するための着信通話ルートを追加します

---

通話受信ルートの追加
==========

ここでは、[応答Webhook](/voice/voice-api/webhook-reference#answer-webhook)を提供して、仮想番号で着信通話を受信すると、Vonage APIプラットフォームがHTTPリクエストを介してそのWebhookに通知するようにします。

Webhookは、1つの`stream`アクションを含む[NCCO](/voice/voice-api/ncco-reference)をVonageに返します。これにより、`STREAM_URL`にあるファイルから通話に音声が再生されます。

テスト目的のために、次のURLを使用します： `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

`VoiceController`クラスに次のコードを追加します

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

