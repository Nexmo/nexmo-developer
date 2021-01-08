---
title:  概述
meta_title: 使用 Verify API 启用 2FA
description: Verify API 可让您确认可使用特定号码与用户联系。（Nexmo 现已更名为 Vonage）

---


Verify API
==========

Verify API 可让您确认可使用特定号码与用户联系，以便您：

* 通过确保您拥有正确的电话号码随时联系用户
* 通过防止一个用户创建多个帐户规避欺诈和垃圾邮件
* 增加额外安全性，以帮助在用户想执行某些活动时确认其身份

工作原理
----

验证是一个两个阶段过程，需要两次 API 呼叫：

### 验证请求

![开始验证过程](/images/verify-request-diag.png)

1. 用户通过您的应用程序或网站注册您的服务，并提供电话号码。

2. 为确认用户可使用其注册的号码，您的应用程序将对[验证请求端点](/api/verify#verifyRequest)进行 API 呼叫。

3. Verify API 会生成 PIN 码并带有关联的 `request_id`。
   > 
   > 在某些情况下可提供您自己的 PIN 码，请与您的客户经理联系。
4. 然后，Verify API 会尝试将此 PIN 发送给用户。这些尝试的格式（SMS 或文本转语音 (TTS)）和计时由您选择的[工作流](/verify/guides/workflows-and-events)定义。
   如果用户不重新访问您的应用或网站以输入他们收到的 PIN，则验证请求最终将超时。否则，您将需要通过执行验证检查来验证他们输入的号码。

### 验证检查

![验证提交的 PIN](/images/verify-check-diag.png)

**5** . 用户收到 PIN 并将其输入您的应用程中。

**6** .您的应用程序将对[验证检查端点](/api/verify#verifyCheck)进行 API 呼叫，并传入 `request_id` 和用户输入的 PIN。

**7** . Verify API 会检查输入的 PIN 与发送的 PIN 是否匹配，并将结果返回到您的应用程序。

入门
---

以下示例显示了如何通过向用户发送验证码来开始验证过程。要了解如何验证用户提供的代码并执行其他操作，请参阅[代码片段](/verify/overview#code-snippets)。

```code_snippets
source: '_examples/verify/send-verification-request'
```

指南
---

```concept_list
product: verify
```

代码片段
----

```code_snippet_list
product: verify
```

用例
---

```use_cases
product: verify
```

延伸阅读
----

* [Verify API 参考](/api/verify)
* [使用 Node.js 实施 Verify API](https://www.nexmo.com/blog/2018/05/10/nexmo-verify-api-implementation-guide-dr/)
* [在 iOS 应用中使用 Verify API](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-swift-ios-apps-dr/)
* [在 Android 应用中使用 Verify API](https://www.nexmo.com/blog/2018/05/10/add-two-factor-authentication-to-android-apps-with-nexmos-verify-api-dr/)

