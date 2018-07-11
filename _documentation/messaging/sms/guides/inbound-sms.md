---
title: Inbound SMS
---

# Inbound SMS

If you rent one or more virtual numbers from Nexmo, inbound messages to that number are sent to your [webhook endpoint](/concepts/guides/webhooks). If a message sent to your virtual number is longer than maximum number of characters, *concat* is *true* and you receive the message in parts. Use the `concat-ref`, `concat-total` and `concat-part` parameters to reassemble the parts into the message.

Inbound messages are sent using a [GET] or [POST] HTTP request to your [webhook endpoint](/concepts/guides/webhooks). When you receive an inbound message, you must send a `200 OK` response. If you do not send the `200 OK`, otherwise Nexmo will resend the inbound message for the next 24 hours.


## Keys and Values

The inbound message includes:

Key | Value | Required
--|--|--
`type` | Possible values are: <ul><li>`text` - standard text.</li><li>`unicode` - [URLencoded ](https://en.wikipedia.org/wiki/Percent-encoding#The_application.2Fx-www-form-urlencoded_type) [unicode](https://en.wikipedia.org/wiki/unicode). This is valid for standard GSM, Arabic, Chinese, double-encoded characters and so on.</li><li>`binary` - a binary message.</li></ul>| Yes
`to` | The phone number the message was sent to. **This is your virtual number**.| Yes
`msisdn` | The phone number that this inbound message was sent from. | Yes
`messageId` | The Nexmo ID for this message.| Yes
`message-timestamp` | The time at [UTC±00:00](https://en.wikipedia.org/wiki/UTC%C2%B100:00) that Nexmo started to push this inbound message to your [webhook endpoint](/concepts/guides/webhooks). The *message-timestamp* is in the following format *YYYY-MM-DD HH:MM:SS*. For example, *2020-01-01 12:00:00*.| Yes
`timestamp` | A unix timestamp representation of *message-timestamp*. | If your messages are [signed](/concepts/guides/signing-messages)
`nonce` | A random string that forms part of the signed set of parameters, it adds an extra element of unpredictability into the signature for the request. You use the *nonce* and *timestamp* parameters with your shared secret to calculate and validate the signature for inbound messages. | If your messages are [signed](/concepts/guides/signing-messages)


**For an inbound message**

Key | Value | Required
-- | -- | --
`text` | The message body for this inbound message.| If *type* is `text` |
`keyword` | The first word in the message body. This is typically used with short codes. | If *type* is `text` |


**For *concatenated* inbound messages**

Key | Value | Required
-- | -- | --
`concat` | *True* - if this is a concatenated message. | Yes
`concat-ref` | The transaction reference. All parts of this message share this `concat-ref`.| If *concat* is *True*
`concat-total` | The number of parts in this concatenated message.| If *concat* is *True*
`concat-part` | The number of this part in the message. Counting starts at *1*. | If *concat* is *True*


**For binary messages**

Key | Value | Required
-- | -- | --
`data` | The content of this message| If *type* is *binary*
`udh` | The hex encoded [User Data Header](https://en.wikipedia.org/wiki/User_Data_Header) | If *type* is *binary*
