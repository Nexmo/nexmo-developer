---
title:  如何运行 Ngrok
description:  如何运行 Ngrok 以在本地测试您的应用程序。

---

<a id="how-to-run-ngrok"></a>

Vonage 的 API 必须可以通过公共互联网访问您的 Webhook。在开发过程中，无需依赖您自己的服务器实现此目标的一种简单方法是使用 [Ngrok](https://ngrok.com/)。要了解更多信息，请[阅读有关 Ngrok 的文档](/tools/ngrok)。

下载并安装 ngrok，然后执行以下命令以将端口 3000 的应用程序公开到公共互联网：

```shell
./ngrok http 3000
```

如果您是付费订阅者，则可以键入：

```shell
./ngrok http 3000 -subdomain=your_domain
```

> **注意** ：在本示例中，Ngrok 会将您在创建 Vonage 应用程序时指定的 Vonage Webhook 转移到 `localhost:3000`。尽管这里显示端口 3000，但是您可以使用任何方便的空闲端口。

