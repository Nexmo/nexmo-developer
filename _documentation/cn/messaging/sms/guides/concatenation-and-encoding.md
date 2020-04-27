---
title:  级联和编码
description:  确定消息的字节长度是否导致将其作为多条短信发送。
navigation_weight:  2

---


级联和编码
=====

当您发送或接收短信消息时，您需要了解消息的总长度，因为它决定了消息是整条到达还是分成两条或更多条消息。短信使用的编码方案（`text` 或 `unicode`）影响到单条消息的最大字符数。

本文档涵盖以下主题：

* [级联](#concatenation)
* [编码](#encoding) 
  * [GSM 字符集](#gsm-character-sets)
  * [Unicode](#unicode)
  * [编码示例](#encoding-examples)

* [最大字符数](#maximum-number-of-characters)
* [入站消息](#inbound-messages)

级联
---

如果您发送的消息字符数超出每条消息的最大字符数，则 Nexmo 会发送 *级联短信* 。级联短信包含多部分短信，这些部分通过[用户数据报头 (UDH)](https://en.wikipedia.org/wiki/User_Data_Header) 中的分段信息连接。

该分段信息将构成级联短信的消息部分的数量以及其中每部分消息的位置告知手机。当手机接收到所有的消息部分时，就会将它们作为单个文本呈现给收件人。

有关更多信息，Nexmo 知识库提供了[多部分短信](https://help.nexmo.com/hc/en-us/articles/204014833-How-is-a-Multipart-SMS-Constructed-)的详细信息。

编码
---

Nexmo 短信 API 支持两种主要的编码类型：`text` 和 `unicode`。

通过在请求中设置 `type` 参数来指定编码。您应该使用的编码取决于消息包含的字符：

* 对于仅包含 [GSM 标准和扩展字符集](#gsm-character-sets)中字符的消息，请将 `type` 参数设置为 `text`。
* 对于包含 [GSM 字符集以外](#unicode)字符（例如中文、日文和韩文字符）的消息，请将 `type` 参数设置为 `unicode`。

### GSM 字符集

Nexmo 支持所有标准 GSM 字符以及 GSM 扩展表中的字符。标准表中的字符需要每个字符 7 位进行编码：
````
! " # $ % ' ( ) * + , - . / : ; < = > ? @ _ ¡ £ ¥ § ¿ & ¤
0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
Ä Å Æ Ç É Ñ Ø ø Ü ß Ö à ä å æ è é ì ñ ò ö ù ü Δ Φ Γ Λ Ω Π Ψ Σ Θ Ξ
````
[扩展表](https://en.wikipedia.org/wiki/GSM_03.38#GSM_7-bit_default_alphabet_and_extension_table_of_3GPP_TS_23.038_/_GSM_03.38)中的字符需要两个字符进行编码：`ESC` 字符前缀，后跟扩展表中的所需字符：
````
| ^ € { } [ ] ~ \
````
### Unicode

阿拉伯文、中文、韩文、日文或西里尔字母语言等语言需要使用超出 GSM 标准和扩展范围的 Unicode 字符。这些字符需要 16 位 UCS-2 编码。

当您将 `type` 参数设置为 `unicode` 时，消息中的 **所有** 字符都使用 UCS-2 编码，即使它们存在于 GSM 标准字符集中。

### 编码示例

|       消息        |    类型     |        每个字符的字节数        | 所需的总字节数 |   消息中使用的字符集    |
|-----------------|-----------|------------------------|---------|----------------|
| `Bonjour monde` | `text`    | 1                      | 13      | GSM 标准         |
| `This ^ That`   | `text`    | 1（2 代表 `^` 因为它在扩展字符集中） | 12      | GSM 标准和 GSM 扩展 |
| `こんにちは世界`       | `unicode` | 2 (UCS-2)        | 14      | Unicode        |

最大字符数
-----

单条短信消息的最大长度为 140 字节，相当于 160 个标准 GSM 7 位字符或 70 个 UCS-2 16 位字符。超出此长度的消息则会分为几部分。

> **注意** ：GSM 扩展表中的字符需要每个字符两个字节进行编码。

如果您要发送 `type` 值为 `text` 的消息，则以下字符限制适用：

| 部分 | 最大字符数 | 计算 |
| -- | -- | -- |
| 1 | 160 | 没有 UDH 则可使用 160 个字符 |
| 2 | 304 | `(160 - 7) * 2 = 306` |
| 3 | 456 | `(160 - 7) * 3 = 459` |
| 4 | 608 | `(160 - 7) * 4 = 612` |

如果您要发送 `type` 为 `unicode` 的消息，则每个字符都需要两个字节。

Nexmo 接受长达 3200 个字符的短信，但并非所有运营商都能接受。最佳做法是确保消息不超过六部分短信。

> 注意：您需要为级联短信中的每部分短信付费。

使用此工具测试您的消息模板：

```partial
source: app/views/tools/concatenation.html
```

入站消息
----

入站消息符合短信规范。如果发送到您的虚拟号码的短信长度大于单条短信允许的[最大字符数](#maximum-number-of-characters)，则您将收到由几部分组成的级联消息。

但是，只有当为您的用户发送短信的运营商支持入站级联短信时，您才能接收这些短信。如果运营商不支持级联，则一个有用的解决方法是将短时间内来自同一号码的所有短信视为级联。有关更多信息，请参阅[入站短信级联](https://help.nexmo.com/hc/en-us/articles/205704158)知识库文章。

有关级联入站短信的更多信息，请参阅[入站短信](inbound-sms)概念文档。

延伸阅读
====

* [单条短信的正文有多长？](https://help.nexmo.com/hc/en-us/articles/204076866-How-long-is-a-single-SMS-body-)

