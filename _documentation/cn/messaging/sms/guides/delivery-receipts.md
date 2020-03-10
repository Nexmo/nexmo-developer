---
title:  传递回执
description:  任何向运营商索取传递回执 (DLR)。
navigation_weight:  4

---


传递回执
====

向短信 API 发出成功请求后，它将返回 `message` 对象的数组，每条消息一个。理想情况下，它们的 `status` 为 `0`，表示成功。但这并不意味着您的消息已送达收件人。这仅表示您的消息已成功加入队列等待发送。

然后，Nexmo 的[自适应路由](https://help.nexmo.com/hc/en-us/articles/218435987-What-is-Nexmo-Adaptive-Routing-)会为您的消息确定最佳运营商。选定的运营商发送消息后，将返回 *传递回执* (DLR)。

要在您的应用程序中接收 DLR，您必须为 Nexmo 提供 [Webhook](/concepts/guides/webhooks) 以便发送。或者，您可以使用[报告 API](/reports/overview) 定期下载您的记录，包括每条消息的传递状态。

> **注意** ：在大多数情况下，DLR 是消息已传递的可靠指示。但是，这不是绝对的保证。请参阅[传递回执的工作原理](#how-delivery-receipts-work)。

传递回执的工作原理
---------

```sequence_diagram
participant Your Application
participant Nexmo
participant Carrier
participant Handset

Your Application->Nexmo: Send an SMS
Nexmo->Carrier: SMS
Carrier->Handset: SMS
Handset->Carrier: Delivery Receipt
Carrier->Nexmo: Delivery Receipt
Nexmo->Your Application: Delivery Receipt Webhook
```

传递回执为：

* **运营商** - 服务提供商收到消息后返回
* **手机** - 用户的手机收到消息后返回

并非所有 DLR 都能保证目标接收到您的消息。有些传递回执仅表示成功完成了传递过程中的一个阶段，例如将消息传递给另一位操作员。其他传递回执是伪造的。因此，Nexmo 无法完全保证 DLR 的准确性。它取决于您要向其发送消息的[国家/地区](/messaging/sms/guides/country-specific-features)以及所涉及的提供商。

如果您的消息长度超出单条短信的发送长度，则消息会[级联](/messaging/sms/guides/concatenation-and-encoding)。您应收到每部分级联短信的运营商 DLR。级联消息的手机 DLR 延迟。这是因为目标手机必须先处理每部分级联消息，然后才能确认收到完整消息。

了解传递回执
------

这是典型的 DLR：

```json
{
  "err-code": "0",
  "message-timestamp": "2018-10-25 12:10:29",
  "messageId": "0B00000127FDBC63",
  "msisdn": "447547232824",
  "network-code": "23410",
  "price": "0.03330000",
  "scts": "1810251310",
  "status": "delivered",
  "to": "Nexmo CLI"
}
```

最重要的字段是 `status` 和 `err-code`，因为它们会告诉您消息是否已传递，如否，则会说明出了什么问题。

### DLR 状态消息

DLR 中的 `status` 字段会告诉您短信是否已成功传递。可能的值为：

|  `status`   |             描述              |
|-------------|-----------------------------|
| `accepted`  | 消息已接受等待传递，但尚未传递             |
| `delivered` | 消息已传递                       |
| `buffered`  | 消息已缓冲等待稍后传递                 |
| `expired`   | 消息已保留在下游运营商的重试方案中，无法在有效期内传递 |
| `failed`    | 消息未传递                       |
| `rejected`  | 下游运营商拒绝传递消息                 |
| `unknown`   | 没有可用的有用信息                   |

### DLR 错误代码

DLR 中的 `err-code` 字段提供了更详细的信息，并且可以帮助解决传递失败的问题。非零代码表示无法传递消息。

| `err-code` |      含义      |                         描述                          |
|------------|--------------|-----------------------------------------------------|
| 0          | 已传递          | 消息已成功传递                                             |
| 1          | 未知           | 消息未传递，无法确定原因                                        |
| 2          | 订户缺席 - 暂时性 | 消息未传递，因为手机暂时不可用 - 重试                              |
| 3          | 订户缺席 - 永久性 | 该号码不再有效，应从数据库中删除                                    |
| 4          | 用户禁止通话       | 这是一个永久性错误：应从数据库中删除该号码，并且用户必须联系其网络运营商以删除该限制          |
| 5          | 可移植性错误       | 存在与号码可移植性相关的问题，您应该与网络运营商联系以解决该问题                    |
| 6          | 反垃圾消息拒绝      | 该消息已被运营商的反垃圾消息过滤器阻止                                 |
| 7          | 手机忙          | 发送消息时手机不可用 - 重试                                   |
| 8          | 网络错误         | 由于网络错误，消息发送失败 - 请重试                               |
| 9          | 非法号码         | 用户已明确要求不接收来自特定服务的消息                                 |
| 10         | 非法消息         | 消息参数中存在错误，例如错误的编码标志                                 |
| 11         | 无法路由         | Nexmo 找不到合适的路由来传递消息 - 联系 mailto:support@nexmo.com |
| 12         | 无法送达目的地      | 找不到号码的路由 - 确认收件人的号码                               |
| 13         | 订户年龄限制       | 由于年龄原因，目标无法收到您的消息                                   |
| 14         | 运营商阻止的号码     | 收件人应要求其运营商在其套餐中启用短信                                 |
| 15         | 预付资金不足       | 收件人使用的是预付费套餐，并且信用额不足以接收您的消息                         |
| 99         | 一般错误         | 通常是指路由中的错误 - 请联系 mailto:support@nexmo.com         |

> DLR 中的其他字段在[API 参考](/api/sms#delivery-receipt)中予以解释。

在营销活动中使用短信 API
--------------

在开始您的消息营销活动之前，请查看要发送到的国家/地区的[特定国家/地区功能指南](/messaging/sms/guides/country-specific-features)。如果您要发送到的国家/地区不提供可靠的 DLR，请使用 [Conversion API](/messaging/conversion-api/overview)为 Nexmo 提供更多数据点并确保最佳路由。

或者，您可以通过在发送的每条消息中添加引用来识别特定的客户或营销活动。这些都包含在传递回执中。通过指定最多 40 个字符的 `client-ref` 参数，将您选择的引用传递到请求中。

其他资源
----

* [Webhooks 指南](/concepts/guides/webhooks) — 如何在 Nexmo 平台上使用 Webhooks 的详细指南
* [为什么我的短信未能传递？](https://help.nexmo.com/hc/en-us/articles/204016013-Why-was-my-SMS-not-delivered-)- 有用的故障排除技巧

