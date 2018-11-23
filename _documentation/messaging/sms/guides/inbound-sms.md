---
title: Inbound SMS
description: How to receive SMS on your Nexmo virtual numbers.
navigation_weight: 5
---

# Inbound SMS

To receive inbound SMS, create a [webhook endpoint](/concepts/guides/webhooks) and configure your account to use it in the API settings tab of the [Nexmo Developer Dashboard](https://dashboard.nexmo.com/settings).

Any messages sent to one of your Nexmo virtual numbers are sent to your webhook using a [GET] or [POST] request. When you receive a message on your webhook, you must send a `200 OK` response. If you don't, then Nexmo will assume that you have not received the message and will keep resending it for the next 24 hours.

Concatenated messages need special attention. See [concatenated inbound messages](#for-concatenated-inbound-messages).

## Anatomy of an Inbound Message

Messages are sent to your webhook endpoint as a JSON object with the following properties:

Key | Value | Required
--|--|--
`type` | Possible values are: <ul><li>`text` - standard text</li><li>`unicode` - a text message that contains Unicode characters<li>`binary` - a binary message</li></ul>| Yes
`to` | The phone number that the message was sent *to*. **This is your virtual number**.| Yes
`msisdn` | The phone number that this inbound message was sent *from*. | Yes
`messageId` | Nexmo's unique identifier for this message.| Yes
`message-timestamp` | The [UTC±00:00](https://en.wikipedia.org/wiki/UTC%C2%B100:00) time when Nexmo started to push this inbound message to your webhook endpoint, in the following format: `YYYY-MM-DD HH:MM:SS`.| Yes
`timestamp` | The [unix timestamp](https://www.unixtimestamp.com/) representation of `message-timestamp`. | No
`nonce` | A random string that adds an extra element of unpredictability into the signature for the request. You use the `nonce` and `timestamp` parameters with your shared secret to calculate and validate the signature for inbound messages. | If your messages are [signed](/concepts/guides/signing-messages)


### For messages of type `text` or `unicode`

If the `type` is `text` or `unicode`, the following properties appear in the request to your webhook endpoint.

Key | Value 
-- | -- 
`text` | The message body for this inbound message.
`keyword` | The first word in the message body. This is typically used with short codes.

### For messages of type `binary`

If the `type` is `binary`, the following properties appear in the request to your webhook endpoint.

Key | Value 
-- | -- 
`data` | The content of this message 
`udh` | The hex encoded [user data header](https://en.wikipedia.org/wiki/User_Data_Header) 

### For concatenated inbound messages

If a message sent to your virtual number fits within the maximum-permitted length of a single message, the following properties do not appear in the request to your webhook endpoint.

If the message is longer than the maximum number of characters allowed in a single message, you will receive the message in parts and the following properties appear in the request.

Use the `concat-ref`, `concat-total` and `concat-part` properties to construct the message from the individual parts.

> Not all carriers support concatenated messages. If the carrier does not support concatenation, the `concat` field will not be present in the payload.

Key | Value 
-- | -- 
`concat` | `true` 
`concat-ref` | The transaction reference. All parts of this message share this `concat-ref`.
`concat-total` | The number of parts in this concatenated message.
`concat-part` | The number of this part in the message. The first part of the message is `1`.

