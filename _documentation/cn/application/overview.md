---
title:  概述
meta_title: 应用程序版本 2 概述
Description:  Vonage API 应用程序包含连接到 Vonage 端点和使用 Vonage API 所需的安全和配置信息。（Nexmo 现已更名为 Vonage）
navigation_weight:  1

---


概述
===

> **注意：** 文档的此部分描述了[应用程序 V2](/api/application.v2) 的功能。

Vonage API 应用程序包含连接到 Vonage 端点和使用 Vonage API 所需的安全和配置信息。

创建的每个 Vonage 应用程序都支持多种功能，例如，您可创建一个支持使用语音、消息和 RTC API 的应用程序。

![应用程序概述](/images/nexmo_application_v2.png "应用程序概述")

为说明 Vonage 应用程序的用途，此处简要介绍如何创建和使用 Vonage 语音应用程序：

1. 使用 CLI、Dashboard 或应用程序 API 创建 Vonage 应用程序。
2. 务必配置您的 Webhook URL。Vonage 将使用重要信息回调这些 URL。
3. 将 Vonage 号码与您的 Vonage 应用程序相关联。
4. 编写您的 Web 应用程序。根据需要，使用 Vonage API 实施在步骤 2 中配置的 Webhook 端点。

例如，要创建[转发入站呼叫](/voice/voice-api/code-snippets/connect-an-inbound-call)到目的地手机的应用程序，则可执行以下步骤：

1. 创建具有语音功能的 Vonage 应用程序。
2. 配置应答和事件 Webhook URL。
3. 将 Vonage 号码与您的 Vonage 应用程序相关联。
4. 实施可响应 Webhook URL 回调的 Web 应用程序。
5. 当对与 Vonage 应用程序关联的 Vonage 号码进行入站呼叫时，将在 `answer_url` 上返回 [NCCO](/voice/voice-api/ncco-reference)。

其他类型的应用程序（例如具有消息和调度功能的应用程序）的过程稍有不同，具体参见此[文档](/application/overview)的相关部分。

以下各部分将详细介绍 Vonage 应用程序。

结构
---

每个应用程序都具有以下内容：

名称 | 描述
-- | --
`id` | 用于标识每个应用程序，并与 `private_key` 一起用于生成 JWT。
`name` | 应用程序名称。
`capabilities` | 描述此应用程序将支持的功能类型。功能 `voice`、`messages`、`rtc` 和 `vbc`。一个应用程序可支持任何数量的这些功能。您还可为每项指定功能设置 `webhooks`。Vonage 通过 Webhook 端点发送和检索信息。
`keys` | 包含 `private_key` 和 `public_key`。使用私钥生成用于验证对 Vonage API 调用的 JWT。Vonage 使用公钥来验证您对 Vonage API 的请求中的 JWT。

功能
---

Vonage 应用程序可以使用各种 API，包括语音、消息、调度、对话和 Client SDK。

创建应用程序时，您可以指定希望应用程序支持的功能。对于每项功能，您都可以根据所需功能来设置 Webhook。例如，对于具有 `rtc` 功能的应用程序，可指定由事件 URL 接收 RTC 事件。如果您的应用程序还需要使用 `voice` 功能，则还可设置一个应答 URL 来接收应答呼叫的 Webhook，一个备用 URL（以免应答 URL 失效）和另一个事件 URL 来接收与语音呼叫相关的事件。

下表提供了功能摘要：

|     功能     |                 描述                  |
|------------|-------------------------------------|
| `voice`    | 用于支持语音功能。                           |
| `messages` | 用于支持消息和调度 API 功能。                   |
| `rtc`      | 用于支持 WebRTC 功能。通常与 Client SDK 组合使用。 |
| `vbc`      | 用于确定定价，但目前没有其他功能。                   |

Webhook
-------

您在创建应用程序时提供的 Webhook URL 取决于所需的应用程序功能。下表总结了 Webhook：

|     功能     |  使用的 API   |                   可用的 Webhook                   |
|------------|------------|-------------------------------------------------|
| `voice`    | 语音         | `answer_url`、`fallback_answer_url`、 `event_url` |
| `messages` | 消息和调度      | `inbound_url`、 `status_url`                     |
| `rtc`      | Client SDK | `event_url`                                     |
| `vbc`      | VBC        | 无                                               |

Webhook 类型
----------

下表描述了每项功能可用的 Webhook：

|     功能     |        Webhook        |                               API                               |                  示例                   |                                                                                                                        描述                                                                                                                         |
|------------|-----------------------|-----------------------------------------------------------------|---------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `voice`    | `answer_url`          | [语音](/voice/voice-api/overview)                                 | https://example.com/webhooks/answer   | 在拨打/接听电话时，Vonage 用于发出请求的 URL。必须返回 NCCO。                                                                                                                                                                                                           |
| `voice`    | `fallback_answer_url` | [语音](/voice/voice-api/overview)                                 | https://example.com/webhooks/fallback | 如果已设置`fallback_answer_url`，则若 `answer_url` 脱机或返回 HTTP 错误代码，或 `event_url` 脱机或返回错误代码且事件预计将返回 NCCO，则 Vonage 会向其发出请求。`fallback_answer_url` 必须返回 NCCO。如果 `fallback_answer_url` 在两次尝试初始 NCCO 后失败，则通话结束。如果 `fallback_answer_url` 在两次尝试进行中的通话失败，则通话流程将继续。 |
| `voice`    | `event_url`           | [语音](/voice/voice-api/overview)                                 | https://example.com/webhooks/event    | Vonage 将发送呼叫事件（例如，振铃、应答）到此 URL。                                                                                                                                                                                                                   |
| `messages` | `inbound_url`         | [消息](/messages/overview)、[调度](/dispatch/overview)               | https://example.com/webhooks/inbound  | Vonage 会将入站消息转发到此 URL。                                                                                                                                                                                                                            |
| `messages` | `status_url`          | [消息](/messages/overview)、[调度](/dispatch/overview)               | https://example.com/webhooks/status   | Vonage 会将消息状态更新（例如 `delivered`、`seen`）发送到此 URL。                                                                                                                                                                                                   |
| `rtc`      | `event_url`           | [Client SDK](/client-sdk/overview)、[对话](/conversation/overview) | https://example.com/webhooks/rtcevent | Vonage 会将 RTC 事件发送到此 URL。                                                                                                                                                                                                                         |
| `vbc`      | 无                     | [语音端点](/voice/voice-api/ncco-reference#connect)                 | 无                                     | 未使用                                                                                                                                                                                                                                               |

创建应用程序
------

创建应用程序有四种主要方法：

1. 在 Vonage [Dashboard](https://dashboard.nexmo.com) 中创建。然后，应用程序会在 Dashboard 的[应用程序](https://dashboard.nexmo.com/applications)部分中列示。
2. 使用 [Nexmo CLI](/application/nexmo-cli)。
3. 使用[应用程序 API](/api/application.v2)。
4. 使用 Vonage [Server SDK](/tools) 之一。

使用 CLI 管理应用程序
-------------

* [使用 Nexmo CLI 管理应用程序](/application/nexmo-cli)

代码片段
----

```code_snippet_list
product: application
```

参考
---

* [应用程序 API](https://developer.nexmo.com/api/application.v2)

