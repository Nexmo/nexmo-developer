---
title:  添加拨打电话操作
description: 向语音控制器添加操作以拨打包含流音频的电话

---

添加拨打电话操作
--------

在语音控制器中，添加新的 HTTP `POST` 路由。您将使用此路由通过 NCCO [`stream`操作](/voice/voice-api/ncco-reference#stream)拨出电话。此操作将在通话中播放位于 `STREAM_URL` 的音频文件。

这将拨打电话，并将单个操作传递给通话，该操作将在通话中播放位于 `STREAM_URL` 的音频文件。

出于测试目的使用 `https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3`

将以下代码添加到 `VoiceController` 类：

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

