---
title:  音声コントローラーを追加する
description:  音声要求を処理するために音声コントローラーをcsprojに追加します

---

音声コントローラーを追加する
==============

`Controllers`フォルダを右クリックし、[Add (追加)]->[Controller (コントローラー)]を選択します。[Add Empty MVC Controller (空のMVCコントローラーを追加)]を選択し、`VoiceController`と名前を付けます。

このファイルの先頭に、`Vonage.Voice`、`Vonage.Voice.Nccos`、`Vonage.Voice.Nccos.Endpoints`、`Vonage.Request`、および`Microsoft.Extensions.Configuration`の`using`ステートメントを追加します。

設定の挿入
-----

依存関係は、コンストラクタを介して`IConfiguration`オブジェクトを注入します：

```csharp
private readonly IConfiguration _config { get; set; }

public VoiceController(IConfiguration config)
{
    _config = config;
}
```

