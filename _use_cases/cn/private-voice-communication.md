---
title: 私人语音通信
products: voice/voice-api
description: 允许用户间可以互相通话，保证真实号码的私密性。
languages:
    - Node
navigation_weight: 2

---

私人语音通信
======

本用例介绍如何实现[私人语音通信用例](https://www.nexmo.com/use-cases/private-voice-communication/)中描述的想法。它教您如何使用 Vonage 的 [Node Server SDK](https://github.com/Nexmo/nexmo-node) 来构建语音代理，该代理使用虚拟号码隐藏参与者的真实电话号码。完整的源代码也可以在我们的 [GitHub 存储库](https://github.com/Nexmo/node-voice-proxy)中找到。

概述
---

有时您希望两个用户能够在不透露私人电话号码的情况下互相通话。

例如，如果您正在经营共享出行服务，那么您希望用户能够互相交谈，协调接载时间和地点。但是，您不想透露客户的电话号码 - 毕竟，您有义务保护他们的隐私。而且，您也不希望他们不使用您的服务就能直接安排共享出行，因为这意味着您会损失业务收入。

借助 Vonage API，您可以为通话中的每个参与者提供一个临时号码，以掩盖他们的真实号码。在通话期间，每个主叫方看到的只是临时号码。当他们不再需要通信时，临时号码就会被撤消。

您可以从我们的 [GitHub 存储库](https://github.com/Nexmo/node-voice-proxy)下载源代码。

先决条件
----

为了完成本用例，您需要：

* [Vonage 帐户](https://dashboard.nexmo.com/sign-up)
* 已安装并配置 [Nexmo CLI](https://github.com/nexmo/nexmo-cli)

代码存储库
-----

有一个[包含代码的 GitHub 存储库](https://github.com/Nexmo/node-voice-proxy)。

步骤
---

要构建该应用程序，请执行以下步骤：

* [概述](#overview)
* [先决条件](#prerequisites)
* [代码存储库](#code-repository)
* [步骤](#steps)
* [配置](#configuration)
* [创建语音 API 应用程序](#create-a-voice-api-application)
* [创建 Web 应用程序](#create-the-web-application)
* [预配虚拟号码](#provision-virtual-numbers)
* [创建呼叫](#create-a-call) 
  * [验证电话号码](#validate-the-phone-numbers)
  * [将电话号码映射到真实号码](#map-phone-numbers-to-real-numbers)
  * [发送确认短信](#send-a-confirmation-sms)

* [处理呼入电话](#handle-inbound-calls)
* [将真实电话号码反向映射到虚拟号码](#reverse-map-real-phone-numbers-to-virtual-numbers)
* [代理呼叫](#proxy-the-call)
* [结语](#conclusion)
* [更多信息](#further-information)

配置
---

你需要创建一个 `.env`包含配置的文件。[GitHub Readme](https://github.com/Nexmo/node-voice-proxy#configuration) 中说明了如何做到这一点。在完成本用例时，可以使用变量（例如 API 密钥、API 密码、应用程序 ID、调试模式和预配的号码）的必需值填充配置文件。

创建语音 API 应用程序
-------------

语音 API 应用程序是一种 Vonage 构造，不应与您要编写的应用程序混淆。它是使用 API 所需的身份验证和配置设置的“容器”。

您可以使用 Nexmo CLI 创建语音 API 应用程序。您必须提供应用程序的名称以及两个 Webhook 端点的 URL：第一个是 Vonage API 在您的虚拟号码收到呼入电话时向其发出请求的端点，第二个是 API 可以在其中发布事件数据的端点。

将以下 Nexmo CLI 命令中的域名替换为您的 ngrok 域名（[如何运行 ngrok](https://developer.nexmo.com/tools/ngrok/)），然后在项目的根目录中运行它：

```shell
nexmo app:create "voice-proxy" --capabilities=voice --voice-answer-url=https://example.com/proxy-call --voice-event-url=https://example.com/event --keyfile=private.key
```

此命令下载包含身份验证信息的 `private.key` 文件，并返回唯一的应用程序 ID。记下该 ID，因为您在后续步骤中会用到它。

创建 Web 应用程序
-----------

该应用使用 [Express](https://expressjs.com/) 框架进行路由，使用 [Vonage Node Server SDK](https://github.com/Nexmo/nexmo-node) 来处理语音 API。我们使用 `dotenv`，以便通过 `.env` 文本文件配置应用

在 `server.js` 中，该代码初始化应用程序的依赖项并启动 web 服务器。为应用的主页 (`/`) 实现一个路由处理程序，以便您可以通过运行 `node server.js` 并在浏览器中访问 `http://localhost:3000` 来测试服务器是否正在运行：

```javascript
"use strict";

const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.set('port', (process.env.PORT || 3000));
app.use(bodyParser.urlencoded({{ extended: false }}));

const config = require(__dirname + '/../config');

const VoiceProxy = require('./VoiceProxy');
const voiceProxy = new VoiceProxy(config);

app.listen(app.get('port'), function() {{
  console.log('Voice Proxy App listening on port', app.get('port'));
}});
```

请注意，该代码实例化 `VoiceProxy` 类的对象，以处理发送到虚拟号码的消息到目标收件人的真实号码的路由。[代理呼叫](#proxy-the-call)中介绍了代理过程，但现在只需要注意，该类使用您在下一步中配置的 API 密钥和密码初始化 Vonage Server SDK。这使您的应用程序可以拨打和接听语音电话：

```javascript
const VoiceProxy = function(config) {{
  this.config = config;
  
  this.nexmo = new Nexmo({{
      apiKey: this.config.VONAGE_API_KEY,
      apiSecret: this.config.VONAGE_API_SECRET
    }},{{
      debug: this.config.VONAGE_DEBUG
    }});
  
  // 待分配给 UserA 和 UserB 的虚拟号码
  this.provisionedNumbers = [].concat(this.config.PROVISIONED_NUMBERS);
  
  // 正在进行的通话
  this.conversations = [];
}};
```

预配虚拟号码
------

虚拟号码用于向应用程序用户隐藏真实电话号码。

以下工作流图表显示了预配和配置虚拟号码的过程：

```sequence_diagram
参与者应用
参与者 Vonage
 参与者 UserA
 参与者 UserB
 Note over App,Vonage: 初始化
应用->>Vonage:搜索号码
 Vonage->>应用：找到的号码
应用->>Vonage:提供号码
 Vonage- ->>应用:预配的号码
应用->> Vonage:配置号码
 Vonage->>应用:已配置的号码
```

要预配虚拟号码，请搜索符合条件的可用号码。例如，特定国家/地区中具有语音功能的电话号码：

```code
source: '_code/voice_proxy.js'
from_line: 2
to_line: 47
```

然后租用所需号码，并将其与应用程序关联。

> **注意：** 某些类型的号码要求您具有邮政地址才能租用。如果无法通过编程方式获取号码，请访问 [Dashboard](https://dashboard.nexmo.com/buy-numbers)，在这里，您可以根据需要租用号码。

当与应用程序关联的各个号码发生任何事件时，Vonage 会向您的 Webhook 端点发送一个请求，以请求事件相关信息。配置完成后，将电话号码存起来供以后使用：

```code
source: '_code/voice_proxy.js'
from_line: 48
to_line: 79
```

要预配虚拟号码，请在浏览器中访问`http://localhost:3000/numbers/provision`。

现在，您已经拥有掩盖用户间通信所需的虚拟号码。

> **注意：** 在生产应用程序中，可从虚拟号码池中进行选择。但是，您应该保留此功能，以便即时租用其他号码。

创建呼叫
----

创建呼叫的工作流为：

```sequence_diagram
参与者应用
参与者 Vonage
 参与者 UserA
 参与者 UserB
 Note over App,Vonage: 对话开始
应用->>Vonage:搜索号码
 Vonage->>Basic Number Insight⏎ Vonage->>应用:Number Insight 响应
应用->>App: Map Real/Virtual Numbers\nfor 每个参与者
应用->>Vonage: 发短信给 UserA 
Vonage->>UserA: 短信 
应用->>Vonage: 发短信给 UserB 
 Vonage->>UserB: 短信
```

以下呼叫：

* [验证电话号码](#validate-phone-numbers)
* [将电话号码映射到真实号码](#map-phone-numbers)
* [发送确认短信](#send-confirmation-sms)

```code
source: '_code/voice_proxy.js'
from_line: 89
to_line: 103
```

### 验证电话号码

当应用程序用户提供其电话号码时，请使用 Number Insight 来确保这些号码有效。您还可以查看电话号码是在哪个国家/地区注册的：

```code
source: '_code/voice_proxy.js'
from_line: 104
to_line: 124
```

### 将电话号码映射到真实号码

一旦确定电话号码有效，就将每个真实号码映射到一个[虚拟号码](#provision-virtual-voice-numbers)并保存呼叫：

```code
source: '_code/voice_proxy.js'
from_line: 125
to_line: 159
```

### 发送确认短信

在私人通信系统中，当一个用户与另一个用户联系时，主叫方用电话拨打虚拟号码。

发短信通知每个对话参与者他们需要拨打的虚拟号码：

```code
source: '_code/voice_proxy.js'
from_line: 160
to_line: 181
```

用户不能互发短信。要启用此功能，您需要设置[私人短信通信](/use-cases/private-sms-communication)。

在本用例中，各用户通过短信收到了虚拟号码。在其他系统中，可以使用电子邮件、应用内通知或以预定义号码的形式提供虚拟号码。

处理呼入电话
------

当 Vonage 收到虚拟号码的呼入电话时，它会向您在[创建语音应用程序](#create-a-voice-application)时设置的 Webhook 端点发出请求：

```sequence_diagram
参与者应用
参与者 Vonage
参与用户 A
 参与用户 B
 用户 A 注释,Vonage: UserA calls UserB's\nVonage Number
用户 A->>Vonage: 拨打虚拟号码
Vonage->>应用:呼入电话（从，至）
```

从入站 Webhook 中提取  和 ，并将它们传递给语音代理业务逻辑：

```javascript
app.get('/proxy-call', function(req, res) {{
  const from = req.query.from;
  const to = req.query.to;

  const ncco = voiceProxy.getProxyNCCO(from, to);
  res.json(ncco);
}});
```

将真实电话号码反向映射到虚拟号码
----------------

您已经知道拨打电话的电话号码和接收者的虚拟号码，现在将入站虚拟号码反向映射到出站真实电话号码：

```sequence_diagram
参与者应用
参与者 Vonage
参与者 UserA
参与者 UserB
UserA->>Vonage: 
Vonage->>应用: 
Note right of App:查找 UserB 的真实号码\n 应用->>应用:号‑码映射查找
```

呼叫方向可以标识为：

* `从`号码是 UserA 真实号码，`至` 号码是 UserB Vonage 号码
* `从`号码是 UserB 真实号码，`至`号码是 UserA Vonage 号码

```code
source: '_code/voice_proxy.js'
from_line: 182
to_line: 216
```

完成号码查找后，剩下的就是代理呼叫了。

代理呼叫
----

将呼叫代理到虚拟号码所关联的电话号码。`从`号码始终是虚拟号码，`至`是真实电话号码。

```sequence_diagram
参与者应用
参与者 Vonage
参与者 UserA
参与者 UserB
UserA->>Vonage: 
Vonage->>应用: 
应用->>Vonage:连接（代理）
Note right of App:将呼入电话代理到 UserB 的真实号码
 Vonage->>UserB: 呼叫
Note over UserA,UserB:UserA 呼叫了 UserB。但 UserA 
没有⏎ UserB 
的真实号码，
反之亦然。
```

为此，请创建一个 [NCCO（Nexmo 呼叫控制对象）](/voice/voice-api/ncco-reference)。该 NCCO 使`对话` 操作来读出一些文本。`对话` 完成后，`内容`操作将呼叫转接到真实号码。

```code
source: '_code/voice_proxy.js'
from_line: 217
to_line: 252
```

Web 服务器将 NCCO 返回给 Vonage。

```javascript
app.get('/proxy-call', function(req, res) {{
  const from = req.query.from;
  const to = req.query.to;

  const ncco = voiceProxy.getProxyNCCO(from, to);
  res.json(ncco);
}});
```

结语
---

您已经学习了如何为私人通信构建语音代理。您预配和配置了电话号码，执行了号码洞察，将真实号码映射到虚拟号码以确保匿名性，处理了呼入电话并将该呼叫代理到另一个用户。

更多信息
----

* [语音 API](/voice/voice-api/overview)
* [NCCO 参考](/voice/voice-api/ncco-reference)
* [GitHub 存储库](https://github.com/Nexmo/node-voice-proxy)

