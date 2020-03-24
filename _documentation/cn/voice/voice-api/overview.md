---
title: 概述
meta_title: 使用 Nexmo 的语音 API 进行文本到语音、IVR、呼叫录音等操作 
navigation_weight: 1
description: 语音 API 概述。
---


语音 API 概述
=========

Nexmo 语音 API 是在云中构建高质量语音应用程序的最简单方法。使用语音 API，您可以：

* 使用您已经在使用的网络技术构建可扩展的应用
* 使用 Nexmo 呼叫控制对象 \(NCCO\) 控制 JSON 中的入站和出站呼叫流程
* 录制和存储呼入或呼出电话
* 创建电话会议
* 以 40 种不同性别和口音的语言发送文本到语音消息

目录
---

在本文档中，您可以了解：

* [Nexmo 语音 API 概念](#concepts)介绍术语
* [**如何开始使用语音 API**](#getting-started)，包括您所用语言的示例
* [指南](#guides) 了解有关使用语音 API 的信息
* [代码片段](#code-snippets) 帮助完成特定任务的代码片段
* [用例](#use-cases) 带有代码示例的详细用例
* [参考](#reference) API 文档和其他支持内容

概念
---

* **使用 JWT 进行身份验证** - 与语音 API 的互动使用 JWT（JSON 网络令牌）进行身份验证。[Nexmo 库](/tools)使用唯一的 Nexmo 语音应用程序 ID 和私钥来处理 JWT 生成。有关更多信息，请参阅[对应用程序进行身份验证](/concepts/guides/authentication)。

* **Nexmo 语音应用程序** - Nexmo 语音应用程序代表您正在构建的应用程序的一对一映射。它们包含虚拟号码和 Webhook 回调 URL 等配置。您可以使用 [Nexmo Dashboard](https://dashboard.nexmo.com/sign-in)、[Nexmo CLI](/tools) 或通过[应用程序 API](/concepts/guides/applications) 创建 Nexmo 语音应用程序。

* **[NCCO](/voice/voice-api/ncco-reference)** - Nexmo 呼叫控制对象是一组指示 Nexmo 如何控制对 Nexmo 应用程序的呼叫的操作。例如，您可以`connect`呼叫，使用`talk`发送合成语音，`stream`音频，或`record`呼叫。它们以 JSON 形式表示为对象数组。有关更多信息，请参阅 [NCCO 参考](/voice/voice-api/ncco-reference)。

* **[号码](/voice/voice-api/guides/numbers)** - Nexmo 语音 API 中使用电话号码的关键概念。

* **[Webhook](/concepts/guides/webhooks)** - 向您的应用程序 Web 服务器发出 HTTP 请求，以便您可以对它们进行操作。例如，来电将发送 Webhook。

入门
---

### 语音 Playground

在 [Nexmo Dashboard](https://dashboard.nexmo.com) 中，您可以在语音 Playground 中交互式地试用语音 API。[注册 Nexmo 帐户](https://dashboard.nexmo.com/signup)后，您可以转到 Dashboard 中的[语音 Playground](https://dashboard.nexmo.com/voice/playground)（语音 ‣ 语音 Playground）。

更多详细信息，请参阅此博客文章：[了解语音 Playground，您的 Nexmo 语音应用测试沙箱](https://www.nexmo.com/blog/2017/12/12/voice-playground-testing-sandbox-nexmo-voice-apps/)

### 使用 API

与 Nexmo 语音平台进行交互的主要方式是通过[公共 API](/voice/voice-api/api-reference) 。要发出呼出电话，您需要向 `https://api.nexmo.com/v1/calls` 发出 `POST` 请求。

为了简化这一过程，Nexmo 提供了各种语言的服务器 SDK，负责身份验证并为您创建正确的请求主体。

首先，请在下面选择您的语言，然后在示例代码中替换以下变量：

密钥 | 说明
-- | --
`NEXMO_NUMBER` | 您拨打电话的 Nexmo 号码。示例：`447700900000`。
`TO_NUMBER` | 您要以 E.164 格式拨打的号码。示例：`447700900001`。

```code_snippets
source: '_examples/voice/make-an-outbound-call'
application:
  type: voice
  name: 'Outbound Call code snippet'
  answer_url: https://developer.nexmo.com/ncco/tts.json
```

指南
---

```concept_list
product: voice/voice-api
```

代码片段
----

```code_snippet_list
product: voice/voice-api
```

用例
---

```use_cases
product: voice/voice-api
```

参考
---

* [语音 API 参考](/api/voice)
* [NCCO 参考](/voice/voice-api/ncco-reference)
* [Webhook 参考](/voice/voice-api/webhook-reference)

