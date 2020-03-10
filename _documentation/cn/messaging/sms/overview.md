---
title: 概述
meta_title: 使用短信 API 发送和接收短信

---


短信 API
======

Nexmo 的短信 API 使您能够使用简单的 REST API 向世界各地的用户发送和接收短信。

* 以编程方式在全球范围内发送和接收大量短信。
* 发送低延迟和高传输率的短信息。
* 使用本地号码接收短信。
* 使用熟悉的 Web 技术扩展您的应用程序。
* 只为使用的功能付费，没有额外收费。

入门
---

### 发送短信

本示例说明如何将短信发送到您选择的号码。

首先，如果您还没有 Nexmo 帐户，请先[注册 Nexmo 帐户](https://dashboard.nexmo.com/sign-up)，然后在 [Dashboard 入门页面](https://dashboard.nexmo.com/getting-started-guide)上记下您的 API 密钥和密码。

在示例代码中替换以下占位符值：

密钥 | 说明
-- | --
`NEXMO_API_KEY` | 您的 Nexmo API 密钥。
`NEXMO_API_SECRET` | 您的 Nexmo API 密码。

```code_snippets
source: '_examples/messaging/sms/send-an-sms'
```

目录
---

本文档的其余部分包含以下信息：

* [Nexmo 短信 API 概念](#concepts) - 注意事项
* [指南](#guides) - 了解如何使用短信 API
* [代码片段](#code-snippets) - 帮助完成特定任务的代码片段
* [用例](#use-cases) - 带有代码示例的详细用例
* [参考](#reference) - 完整的 API 文档

概念
---

在使用 Nexmo 短信 API 之前，请先熟悉以下内容：

* **[号码格式](/voice/voice-api/guides/numbers)** - 短信 API 要求使用 E.164 format 的电话号码。

* **[身份验证](/concepts/guides/authentication)** - 短信 API 使用您的帐户 API 密钥和密码进行身份验证。

* **[Webhook](/concepts/guides/webhooks)** - 短信 API 向您的应用程序 Web 服务器发出 HTTP 请求，以便您可以对它们进行操作。例如：入站短信和传输收据。

指南
---

```concept_list
product: messaging/sms
```

代码片段
----

```code_snippet_list
product: messaging/sms
```

用例
---

```use_cases
product: messaging/sms
```

参考
---

* [短信 API 参考](/api/sms)

