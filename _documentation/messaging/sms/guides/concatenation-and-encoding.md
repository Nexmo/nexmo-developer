---
title: Concatenation and Encoding
---

# Concatenation and Encoding

When you send or receive an SMS message, you need to be aware of which encoding scheme the message uses because it can affect whether the message arrives in one piece or is split into parts.

If you send a message that contains more than the maximum number of characters per message for your chosen encoding, Nexmo sends a *concatenated SMS*. A concatenated SMS contains multiple SMS parts that are connected by segmentation information in the [User Data Header (UDH)](https://en.wikipedia.org/wiki/User_Data_Header).

This segmentation information tells the handset the number of message parts that make up the concatenated SMS, and the position of each SMS part within it. When the handset has received all of the SMS parts, it presents the message to the recipient as a single text.

## Encoding

Specify the encoding by setting the `type` parameter in the request. The encoding you should use depends on the characters that the message contains:

1. Messages that only contain characters in the GSM standard and extended character sets should have the `type` request parameter set to `text`.
2. Messages that contain characters outside of the GSM character sets (such as Chinese, Japanese and Korean characters) should have `type` set to `unicode`.

### GSM character sets

Nexmo supports all the standard GSM characters as well as characters from the GSM extended table. Characters from the standard table require 7-bits per character to encode:

````
! " # $ % ' ( ) * + , - . / : ; < = > ? @ _ ¡ £ ¥ § ¿ & ¤
0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
Ä Å Æ Ç É Ñ Ø ø Ü ß Ö à ä å æ è é ì ñ ò ö ù ü Δ Φ Γ Λ Ω Π Ψ Σ Θ Ξ
````

Characters from the [extended table](https://en.wikipedia.org/wiki/GSM_03.38#GSM_7-bit_default_alphabet_and_extension_table_of_3GPP_TS_23.038_/_GSM_03.38) require two bytes per character to encode, the first prefix character is `ESC` followed by the character from the extended table:

````
| ^ € { } [ ] ~ \
````

Messages that only use GSM standard or extended characters should have their `type` set to `text`. 

### Unicode

Languages such as Arabic, Chinese, Korean, Japanese, or Cyrillic alphabet languages require Unicode characters beyond the GSM standard and extended ranges. These characters require 16-bit UCS-2 encoding. 

If your message includes any of these characters, you must set the `type` to `unicode`. When you choose this encoding, *all* characters within the message are encoded using UCS-2, even if they are present in the GSM standard or extended character sets.

## Examples

| Message | Type | Bytes per character | Character set used in messagee |
|---|---|---|---|
| `Bonjour monde` | `text` | 1 | GSM standard |
| `This ^ That ` | `text` | 1 and 2 for `^` | GSM standard and GSM extended |
| `こんにちは世界` | `unicode` | 2 (UCS-2) | Unicode | 

## Maximum number of characters

The maximum number of characters you can fit into a single SMS depends on the type of encoding.

If you are sending a message with a `type` value of `text` then the following character limits apply:

| Parts | Maximum Characters | Calculation |
| -- | -- | -- |
| 1 | 160 | Without UDH 160 characters are available |
| 2 | 304 | `(160 - 8) * 2 = 304` |
| 3 | 456 | `(160 - 8) * 3 = 456` |
| 4 | 608 | `(160 - 8) * 4 = 608` |

If you are sending a message with a `type` of `unicode` then each character in the message requires two bytes.

Test your message templates with this tool:

```partial
source: app/views/tools/concatenation.html
```

Nexmo accepts SMS of up to 3200 characters long but not all carriers do. It is best practice to ensure that the message does not exceed six SMS parts.

> Note: You are charged for each SMS part in a concatenated SMS.

## Inbound Messages

Inbound messages comply with the SMS specification. If an SMS sent to your virtual number is longer than the [maximum number of characters](#maximum-number-of-characters) allowed for a single SMS, you will receive the concatenated message in parts.

However, you can only receive inbound concatenated SMS if the carrier your user is sending through supports them. If the carrier does not support concatenation then a useful workaround is to treat all SMS from the same number within a short time window as concatenated.

See the [Inbound SMS](inbound-sms) concept document for more information about concatenating inbound SMS.