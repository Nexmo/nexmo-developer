---
title:  Nexmo CLI
meta_title:  Nexmo 命令行界面（CLI
Description:  Nexmo CLI 可用于创建和管理应用程序。
navigation_weight:  2

---


使用 Nexmo CLI 管理应用程序
===================

Nexmo CLI 允许您创建和管理 Vonage 应用程序。要获得帮助，请在安装 CLI 后立即输入 `nexmo`。

安装
---

可使用以下命令安装 Nexmo CLI（测试版）：

```shell
npm install -g nexmo-cli@beta
```

最新测试版包括在命令行上支持应用程序 API V2 所需的所有工具。您可使用以下命令检查安装的版本：

```shell
nexmo --version
```

列出您的应用程序
--------

列出您当前应用程序的用途：

```shell
nexmo app:list
```

这将显示一个列示应用程序 ID 和名称的列表。

显示应用程序详细信息
----------

显示某个特定应用程序的详细信息（其中 `APP_ID` 是已存在的应用程序的 ID）：

```shell
nexmo app:show APP_ID
```

返回以下类似内容：

```shell
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...n9efcS+L...
-----END PUBLIC KEY-----

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345

[voice.webhooks.0.endpoint_type]
event_url

[voice.webhooks.0.endpoint]
https://example.ngrok.io/webhooks/event

[voice.webhooks.0.http_method]
POST

[voice.webhooks.1.endpoint_type]
answer_url

[voice.webhooks.1.endpoint]
https://example.ngrok.io/webhooks/answer

[voice.webhooks.1.http_method]
GET
```

或以应用程序 V2 格式显示结果：

```shell
nexmo as APP_ID --v2
```

这将返回：

```shell
[id]
61fd1849-280d-4722-8712-1cc59aa12345

[name]
My Client SDK App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...DAQAB...
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
https://example.ngrok.io/webhooks/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
https://example.ngrok.io/webhooks/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[_links.self.href]
/v2/applications/61fd1849-280d-4722-8712-1cc59aa12345
```

这会显示应用程序 V2 [的功能](/application/overview#capabilities)。

对于消息应用程序，命令可能是：

```shell
nexmo as 43fd399e-0f17-4027-83b9-cc16f4a12345 --v2
```

这将返回以下类似内容：

```shell
[id]
43fd399e-0f17-4027-83b9-cc16f4a12345

[name]
FaceBook Messenger App

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MIIB...AQAB...
-----END PUBLIC KEY-----

[capabilities.messages.webhooks.inbound_url.address]
https://example.ngrok.io/webhooks/inbound

[capabilities.messages.webhooks.inbound_url.http_method]
POST

[capabilities.messages.webhooks.status_url.address]
https://example.ngrok.io/webhooks/status

[capabilities.messages.webhooks.status_url.http_method]
POST

[_links.self.href]
/v2/applications/43fd399e-0f17-4027-83b9-cc16f4a12345
```

请注意，在这种情况下，将显示消息[功能](/application/overview#capabilities)。

创建应用程序
------

### 交互模式

首先，为您的应用程序和相关更改创建一个新目录。然后，您可使用以下命令以 **交互模式** 创建应用程序：

```shell
nexmo app:create
```

系统将提示您选择所需的应用程序功能。您可以为您的应用程序选择任意多个功能。然后，系统将根据您选择的功能提示您输入 Webhook URL。例如，如果您请求 `rtc` 功能，则系统将提示您输入 RTC 事件 Webhook URL。

请注意，将来可用于重新创建应用程序的命令也会显示为输出的一部分。这对于未来参考很有用，例如，如果您以后想使用脚本创建类似的应用程序。

### 脚本模式

要创建没有交互模式（可用于脚本）的应用程序，请使用如下命令：

```shell
nexmo app:create "Test Application 1" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

这将在项目目录中创建 `.nexmo-app` 文件，其中包含应用程序 ID 和私钥。您还可将显示的私钥复制并粘贴到 `private.key` 文件中。

请注意，您需要设置的 Webhook URL 取决于您选择的功能。[应用程序 Webhook](/application/overview#webhooks) 主题中对此进行了详细说明。

使用您自己的公钥/私钥对创建应用程序
------------------

如果您已经拥有合适的公钥/私钥对，则可使用您自己的公钥创建应用程序。

首先，您需要一个合适的公钥/私钥对。要想创建一对，请先输入：

```shell
ssh-keygen -t rsa -b 4096 -m PEM -f private.key
```

按下 Enter 键（两次）以停用密码口令。这将生成您的私钥 `private.key`。

然后，输入以下内容：

```shell
openssl rsa -in private.key -pubout -outform PEM -out public.key.pub
```

这将生成 `public.key.pub`。这就是您在创建或更新 Vonage 应用程序时使用的公钥：

```shell
nexmo app:update asdasdas-asdd-2344-2344-asdasd12345 "Application with Public Key" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent --public-keyfile=public.key.pub
```

重新创建应用程序
--------

您可以使用 `--recreate` `app:show` 选项查看应用程序的创建方式。例如，命令：

```shell
nexmo app:show 9a1089f2-3990-4db2-be67-3e7767bd20c9  --recreate
```

将生成以下输出：

```shell
[id]
9a1089f2-3990-4db2-be67-3e7767bd20c9

[name]
APP_NAME

[keys.public_key]
-----BEGIN PUBLIC KEY-----
MII...EAAQ==
-----END PUBLIC KEY-----


[capabilities.voice.webhooks.event_url.address]
http://example.com/event

[capabilities.voice.webhooks.event_url.http_method]
POST

[capabilities.voice.webhooks.answer_url.address]
http://example.com/answer

[capabilities.voice.webhooks.answer_url.http_method]
GET

[capabilities.voice.webhooks.fallback_answer_url.address]


[capabilities.voice.webhooks.fallback_answer_url.http_method]
GET

[capabilities.rtc.webhooks.event_url.address]
http://example.com/rtcevent

[capabilities.rtc.webhooks.event_url.http_method]
POST

[_links.self.href]
/v2/applications/9a1089f2-3990-4db2-be67-3e7767bd20c9


To recreate a similar application use the following command:

nexmo app:create DELETE ME FOREVER --capabilities=voice,rtc --voice-answer-url=http://example.com --voice-fallback-answer-url= --voice-event-url=http://example.com --rtc-event-url=http://example.com 
```

注意，用于 *重新创建* 此应用程序的命令显示在输出的末尾。

更新应用程序
------

您可以使用类似下面的命令来更新先前创建的应用程序：

```shell
nexmo app:update asdasdas-asdd-2344-2344-asdasda12345 "Updated Application" --capabilities=voice,rtc --voice-event-url=http://example.com/webhooks/event --voice-answer-url=http://example.com/webhooks/answer --rtc-event-url=http://example.com/webhooks/rtcevent
```

您可以更改应用程序名称、修改任何 Webhook 或添加新功能。

删除应用程序
------

您可以使用以下命令删除应用程序：

```shell
nexmo app:delete APP_ID
```

系统将要求您确认删除。

> **注意：** 删除不可撤销。

参考
---

* [Nexmo CLI GitHub 存储库](https://github.com/Nexmo/nexmo-cli)

