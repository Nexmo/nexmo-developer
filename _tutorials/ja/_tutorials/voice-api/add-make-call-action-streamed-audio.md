---
title:  呼び出しアクションの追加
description:  音声コントローラーにアクションを追加して、ストリーミングされた音声で呼び出しを発信する

---

呼び出しアクションの追加
------------

音声コントローラーで、新しいHTTP `POST`ルートを追加します。これを使用して、NCCO [`stream`アクション](/voice/voice-api/ncco-reference#stream)で発信通話を行います。このアクションでは、呼び出し時に`STREAM_URL`にあるオーディオファイルを再生します。

これにより呼び出しが発信され、その呼び出しに1つのアクションが受け渡され、`STREAM_URL`にあるオーディオファイルが呼び出し時に再生されます。

テスト目的で使用する場合 `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

`VoiceController`クラスに次のコードを追加します：

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

