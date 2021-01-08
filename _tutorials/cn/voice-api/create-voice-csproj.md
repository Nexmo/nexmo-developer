---
title:  创建 .NET 语音应用程序
description:  介绍如何为 .NET 语音应用程序创建 csproj。

---

创建语音项目文件
========

首先，您将创建一个语音 `csproj` 文件。为了简化测试，请在禁用 HTTPS 的情况下配置 Kestrel。

在终端执行以下命令：

```shell
dotnet new mvc --no-https -n VonageVoice
```

