---
title: Concatenation and encoding
description: Determining whether the byte length of a message results in it being sent as multiple SMS.
navigation_weight: 2
---

# Concatenation and Encoding

When you send or receive an SMS message you need to be aware of the overall length of the message because it determines whether the message arrives in one piece or is split into two or more messages. The encoding scheme the SMS uses (`text` or `unicode`) affects the maximum number of characters that will fit into a single message.

This document covers the following topics:

* [Concatentation](#concatenation)
* [Encoding](#encoding)
    * [GSM character sets](#gsm-character-sets)
    * [Unicode](#unicode)
    * [Encoding examples](#encoding-examples)
* [Maximum number of characters](#maximum-number-of-characters)
* [Inbound Messages](#inbound-messages)

## Concatenation

If you send a message that contains more than the maximum number of characters per message, Nexmo sends a *concatenated SMS*. A concatenated SMS contains multiple SMS parts that are connected by segmentation information in the [User Data Header (UDH)](https://en.wikipedia.org/wiki/User_Data_Header).

This segmentation information tells the handset the number of message parts that make up the concatenated SMS and the position of each message part within it. When the handset has received all of the message parts, it presents them to the recipient as a single text.

For more information, the Nexmo Knowledgebase has detailed information about [Multipart SMS](https://help.nexmo.com/hc/en-us/articles/204014833-How-is-a-Multipart-SMS-Constructed-).

## Encoding

There are two main types of encoding that the Nexmo SMS API supports: `text` and `unicode`.

Specify the encoding by setting the `type` parameter in the request. The encoding you should use depends on the characters that the message contains:

* Set the `type` parameter to `text` for messages that only contain characters in the [GSM standard and extended character sets](#gsm-character-sets).
* Set the `type` parameter to `unicode` for messages that contain characters [outside of the GSM character sets](#unicode) (such as Chinese, Japanese and Korean characters).

### GSM character sets

Nexmo supports all the standard GSM characters as well as characters from the GSM extended table. Characters from the standard table require 7-bits per character to encode:

````
! " # $ % ' ( ) * + , - . / : ; < = > ? @ _ ¡ £ ¥ § ¿ & ¤
0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
Ä Å Æ Ç É Ñ Ø ø Ü ß Ö à ä å æ è é ì ñ ò ö ù ü Δ Φ Γ Λ Ω Π Ψ Σ Θ Ξ
````

Characters from the [extended table](https://en.wikipedia.org/wiki/GSM_03.38#GSM_7-bit_default_alphabet_and_extension_table_of_3GPP_TS_23.038_/_GSM_03.38) require two characters to encode: an `ESC` character prefix followed by the required character from the extended table:

````
| ^ € { } [ ] ~ \
````

### Unicode

Languages such as Arabic, Chinese, Korean, Japanese, or Cyrillic alphabet languages require Unicode characters beyond the GSM standard and extended ranges. These characters require 16-bit UCS-2 encoding. 

When you set the `type` parameter to `unicode`, **all** characters within the message are encoded using UCS-2, even if they are present in the GSM standard character set.

### Encoding examples

| Message | Type | Bytes per character | Total bytes required | Character set used in message |
|---|---|---|---|---|
| `Bonjour monde` | `text` | 1 | 13  | GSM standard |
| `This ^ That` | `text` | 1 (2 for `^` as it's in the extended character set) | 12 | GSM standard and GSM extended |
| `こんにちは世界` | `unicode` | 2 (UCS-2) | 14 | Unicode |

## Maximum number of characters

The maximum length of a single SMS message is 140 bytes, which equates to 160 standard GSM 7-bit characters or 80 UCS-2 16-bit characters. A message longer than that is split into parts.

> **Note**: Characters from the GSM extended table require two bytes per character to encode.

If you are sending a message with a `type` value of `text` then the following character limits apply:

| Parts | Maximum Characters | Calculation |
| -- | -- | -- |
| 1 | 160 | Without UDH 160 characters are available |
| 2 | 304 | `(160 - 8) * 2 = 304` |
| 3 | 456 | `(160 - 8) * 3 = 456` |
| 4 | 608 | `(160 - 8) * 4 = 608` |

If you are sending a message with a `type` of `unicode` then each character in the message requires two bytes.

Nexmo accepts SMS up to 3200 characters long but not all carriers do. It is best practice to ensure that the message does not exceed six SMS parts.

> Note: You are charged for each SMS part in a concatenated SMS.

Test your message templates with this tool:

```partial
source: app/views/tools/concatenation.html
```

## Inbound Messages

Inbound messages comply with the SMS specification. If an SMS sent to your virtual number is longer than the [maximum number of characters](#maximum-number-of-characters) allowed for a single SMS, you will receive the concatenated message in parts.

However, you can only receive inbound concatenated SMS if the carrier your user is sending through supports them. If the carrier does not support concatenation then a useful workaround is to treat all SMS from the same number within a short time window as concatenated. See the [inbound SMS concatenation](https://help.nexmo.com/hc/en-us/articles/205704158) Knowledge Base article for more information.

See the [Inbound SMS](inbound-sms) concept document for more information about concatenating inbound SMS.

# Further Reading
* [How long is a single SMS body?](https://help.nexmo.com/hc/en-us/articles/204076866-How-long-is-a-single-SMS-body-)
