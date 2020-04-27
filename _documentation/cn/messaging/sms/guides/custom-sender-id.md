---
title:  发件人身份
description:  如何更改短信显示的来源。
navigation_weight:  1

---


发件人身份
=====

您的消息发送地将显示为您在请求的 `from` 参数中输入的任何允许值。您可能希望使用此功能来更好地代表您的品牌，并最大程度地提高读者数量和响应率。

但是，此参数可以包含的内容有限制。您还应注意，只有当 `from` 参数包含能够接受入站短信的有效手机号码时，消息收件人才能响应。

> 请注意，Nexmo 明确禁止使用发件人 ID 来冒充其他人员、公司或产品的[短信欺骗](https://en.wikipedia.org/wiki/SMS_spoofing)。

有效
---

请求中的 `from` 参数只能包含遵循某些规则的数字或字母数字值：

* **数字** 
  * 必须为最多 15 位数字的电话号码
  * 必须为[国际格式](/concepts/guides/glossary#number-format)
  * 不能包含 `+` 开头或 `00`

* **字母数字** 
  * 必须为最多 11 ^[个支持的字符](abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789) 的字符串。
  * 不能包含空格

> **注意** ：如果您的 `from` 参数中的值不遵循这些规则，则可能在传输过程中对其进行修改或完全不传递。

特定国家/地区注意事项
-----------

一些国家/地区对您的消息显示的发送地施加了进一步的限制，例如：

* 它必须是一个虚拟号码
* 您所述的电话号码可能会替换为[短代码](https://en.wikipedia.org/wiki/Short_code)

如果您的短信似乎不是来自有效的电话号码，则您可以：

* 通过短信过滤更改发件人详细信息
* 仅允许在一天中的特定时间发送短信
* 如果您的短信是出于营销目的，则需要实施 [STOP 系统](https://developer.nexmo.com/api/sms/us-short-codes/alerts/subscription)

在开始您的消息营销活动之前：

1. 请查看[本文档](https://help.nexmo.com/hc/en-us/articles/115011781468)中目标国家/地区的 `SenderID` 列。
2. 将您的所有消息批量发送到同一国家/地区的号码，并设置发件人身份以匹配该国家/地区所允许的内容。

