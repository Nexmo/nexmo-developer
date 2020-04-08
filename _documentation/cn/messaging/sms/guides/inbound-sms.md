---
title:  入站短信
description:  如何在 Nexmo 虚拟号码上接收短信。
navigation_weight:  5

---


入站短信
====

要接收入站短信，请创建 [Webhook 端点](/concepts/guides/webhooks)并在 [Nexmo Developer Dashboard](https://dashboard.nexmo.com/settings) 的 API 设置选项卡中配置您的帐户以使用它。

使用 [GET] 或 [POST] 请求将发送到您的 Nexmo 虚拟号码之一的所有消息都发送到您的 Webhook。当您在 Webhook 上收到消息时，必须发送 `200 OK` 响应。如若不然，则 Nexmo 将假定您尚未收到该消息，并将在接下来的 24 小时内重新发送该消息。

级联消息需要特别注意。请参阅[级联入站消息](#for-concatenated-inbound-messages)。

入站消息剖析
------

消息将作为具有以下属性的 JSON 对象发送到您的 Webhook 端点：

关键 | 值 | 必填
--|--|--
`type` | 可能的值为： * `text` - 标准文本 * `unicode` - 包含 Unicode 字符的短信 * `binary` - 二进制消息 | 是 `to` | 消息发送 *到* 的电话号码。 **这是您的虚拟号码** 。|是 `msisdn` | 此入站消息发送 *自* 的电话号码。| 是 `messageId` | Nexmo 对此消息的唯一标识符。|是 `message-timestamp` | Nexmo 开始按以下格式将入站消息推送到您的 Webhook 端点的 [UTC±00:00](https://en.wikipedia.org/wiki/UTC%C2%B100:00) 时间：`YYYY-MM-DD HH:MM:SS`。|是 `timestamp` | [unix 时间戳](https://www.unixtimestamp.com/)代表的 `message-timestamp`。| 否 `nonce` | 一个将不可预测的额外元素添加到请求签名中的随机字符串。您可以将 `nonce` 和 `timestamp` 参数与共享密码一起使用，以计算和验证入站消息的签名。| 如果您的消息[已签名](/concepts/guides/signing-messages)

### 对于消息类型为 `text` 或 `unicode`

如果 `type` 为 `text` 或 `unicode`，则以下属性会出现在对 Webhook 端点的请求中。

关键 | 值
-- | --
`text` | 此入站消息的消息正文。
`keyword` | 信息正文中的第一个单词。这通常与短代码一起使用。

### 对于消息类型为 `binary`

如果 `type` 为 `binary`，则以下属性会出现在对 Webhook 端点的请求中。

关键 |值
-- | --
`data` | 该消息的内容
`udh` | 十六进制编码的[用户数据报头](https://en.wikipedia.org/wiki/User_Data_Header)

### 对于级联的入站消息

如果发送到您的虚拟号码的消息符合单条消息的最大允许长度，则以下属性不会出现在对 Webhook 端点的请求中。

如果该消息长度超出单条消息中允许的最大字符数，则您将部分接收消息，并且以下属性会出现在请求中。

使用 `concat-ref`、`concat-total` 和 `concat-part` 属性可以从各个部分构造消息。

> 并非所有运营商都支持级联消息。如果运营商不支持级联，则净荷中将不存在 `concat` 字段。

关键 | 值
-- | --
`concat` | `true`
`concat-ref` | 交易参考。该消息的所有部分共享此 `concat-ref`。
`concat-total` | 此级联消息中的部分数量⏎`concat-part` | 消息中该部分的编号。消息的第一部分为 `1`。

