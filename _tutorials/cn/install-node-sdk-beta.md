---
title:  安装 Node Beta Server SDK
description:  安装 Vonage Node Beta Server SDK 以获取最新功能。

---

如果您打算使用 JavaScript 开发应用程序，则需要安装（或更新）Vonage Node Server SDK 的测试版。

### 安装

测试期间，可以使用以下命令安装 Node Server SDK：

```bash
$ npm install --save nexmo@beta
```

如果您已经安装了 Server SDK，则上述命令会将您的 Server SDK 升级到最新版本。

### 用途

如果您决定使用 Server SDK，则需要以下信息：

|键 | 说明|
|-- | --|
|`NEXMO_API_KEY` | 您可以从 [Dashboard](https://dashboard.nexmo.com) 获取的 Vonage API 密钥。|
|`NEXMO_API_SECRET` | 您可以从 [Dashboard](https://dashboard.nexmo.com) 获取的 Vonage API 密码。|
|`NEXMO_APPLICATION_ID` | 您可以从 [Dashboard](https://dashboard.nexmo.com) 获取的 Vonage 应用程序 ID。|
|`NEXMO_APPLICATION_PRIVATE_KEY_PATH` | 创建 Vonage 应用程序时生成的 `private.key` 文件的路径。|

然后，可以在 Server SDK 示例代码中将这些变量替换为实际值。

