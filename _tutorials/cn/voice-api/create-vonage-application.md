---
title:  创建语音应用程序
description:  在此步骤中，您将学习如何创建语音应用程序。语音应用程序具有应答 Webhook 和事件 Webhook。
meta_title:  创建 Vonage API 的语音应用程序
meta_description:  语音应用程序具有应答 Webhook 和事件 Webhook。

---

有两种方法可以创建语音应用程序：

1. 使用 Nexmo CLI
2. 使用 Dashboard

以下各节介绍了每种方法。

### 如何使用 Nexmo CLI 创建语音应用程序

要使用 Nexmo CLI 创建您的应用程序，请在 shell 中输入以下命令，将 `NGROK_HOST_NAME` 替换为您在设置 ngrok 时获取的 ngrok 主机：

```shell
nexmo app:create "AspNetTestApp" http://NGROK_HOST_NAME/webhooks/answer http://NGROK_HOST_NAME/webhooks/events
```

此命令用于创建具有语音[功能](/application/overview#capabilities)的 Vonage 应用程序。它使用应答和事件 Webhook URL 配置应用程序，并生成私钥文件 `private.key`，您应将该文件保存在项目目录中。

此命令返回唯一的应用程序 ID。通过执行以下命令，使用此应用程序 ID 将您的 Vonage 虚拟号码链接到应用程序：

```shell
nexmo link:app VONAGE_NUMBER APPLICATION_ID
```

此操作将该 Vonage 虚拟号码链接到您的应用程序，这将导致该号码发生的所有语音事件都被路由至指定 URL。

### 如何使用 Dashboard 创建语音应用程序

您可以在 [Dashboard](https://dashboard.nexmo.com/applications) 中创建语音应用程序。

要使用 Dashboard 创建您的应用程序：

1. 在 Dashboard 中的[应用程序](https://dashboard.nexmo.com/applications)下，点击 **创建新的应用程序** 按钮。

2. 在 **名称** 下，输入应用程序名称。选择一个名称以便将来引用。

3. 点击 **生成公钥和私钥** 按钮。这将生成一个公钥/私钥对，并且您的浏览器将会下载私钥。保存生成的私钥。

4. 在 **功能** 下，选择 **语音** 按钮。

5. 在 **应答 URL** 框中，输入您的呼入电话 Webhook 的 URL，例如 `http://example.com/webhooks/answer`。

6. 在 **事件 URL** 框中，输入您的通话状态 Webhook 的 URL，例如 `http://example.com/webhooks/events`。

7. 点击 **生成新的应用程序** 按钮。

8. 现在进入"创建应用程序"流程的下一步，在此步骤中，您可以将 Vonage 号码链接到此应用程序。

现在您已经创建了您的应用程序。

> **注意** ：测试您的应用程序前，确保已配置 Webhook 并且 Webhook 服务器正在运行。

