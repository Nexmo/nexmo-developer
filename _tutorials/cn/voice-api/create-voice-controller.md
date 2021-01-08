---
title:  添加语音控制器
description:  将语音控制器添加到 csproj 以处理语音请求

---

添加语音控制器
=======

右键点击 `Controllers` 文件夹，然后选择"添加 -> 控制器"。选择"添加空 MVC 控制器"并将其命名为 `VoiceController`。

在此文件顶部为 `Vonage.Voice`、`Vonage.Voice.Nccos`、`Vonage.Voice.Nccos.Endpoints`、`Vonage.Request` 和 `Microsoft.Extensions.Configuration` 添加 `using` 语句。

注入配置
----

依赖项通过构造函数注入 `IConfiguration` 对象：

```csharp
private readonly IConfiguration _config { get; set; }

public VoiceController(IConfiguration config)
{
    _config = config;
}
```

