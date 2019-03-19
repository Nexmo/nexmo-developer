---
title: Troubleshooting
description: What to do if your SMS delivery fails.
navigation_weight: 6
---

# Troubleshooting SMS

When you [send an SMS](/messaging/sms/code-snippets/send-an-sms), the SMS API returns a JSON response that contains an array of `message` objects, one for each message:

```json
{
    "message-count": "1",
    "messages": [
        {
            "to": "447700900000",
            "message-id": "0C000000217B7F02",
            "status": "0",
            "remaining-balance": "15.53590000",
            "message-price": "0.03330000",
            "network": "23410"
        }
    ]
}
```

The `status` field tells you if the message was successfully queued for sending. A status of zero indicates success; a non-zero value means something went wrong.

> Note: A `status` of zero in the API response does not indicate that Nexmo delivered your message. See [What else could have gone wrong?](#what-else-could-have-gone-wrong)

## SMS API error codes

If the SMS API returns a non-zero `status` value then use the following table to determine what went wrong:

| `status` | Meaning | Description |
|---|---|---|
| 0 | Success  | The message was successfully accepted for delivery.
| 1 | Throttled | You are sending SMS faster than the account limit (see [What is the Throughput Limit for Outbound SMS?](https://help.nexmo.com/hc/en-us/articles/203993598)). |
| 2 | Missing Parameters | Your request is missing one of the required parameters: `from`, `to`, `api_key`, `api_secret` or `text`. |
| 3 | Invalid Parameters | The value of one or more parameters is invalid.
| 4 | Invalid Credentials | Your API key and/or secret are incorrect, invalid or disabled.
| 5 | Internal Error | An error has occurred in the platform whilst processing this message.
| 6 | Invalid Message | The platform was unable to process this message, for example, an un-recognized number prefix.
| 7 | Number Barred | The number you are trying to send messages to is blacklisted and may not receive them.
| 8 | Partner Account Barred  | Your Nexmo account has been suspended. Contact <support@nexmo.com>. |
| 9 | Partner Quota Violation  | You do not have sufficient credit to send the message. Top-up and retry.  |
| 10 | Too Many Existing Binds | The number of simultaneous connections to the platform exceeds your account allocation.
| 11 | Account Not Enabled For HTTP | This account is not provisioned for the SMS API, you should use SMPP instead.
| 12 | Message Too Long | The message length exceeds the maximum allowed.
| 14 | Invalid Signature | The signature supplied could not be verified.
| 15 | Invalid Sender Address | You are using a non-authorized sender ID in the `from` field. This is most commonly in North America, where a Nexmo long virtual number or short code is required.  |
| 22 | Invalid Network Code | The network code supplied was either not recognized, or does not match the country of the destination address.
| 23 | Invalid Callback Url | The callback URL supplied was either too long or contained illegal characters.
| 29 | Non-Whitelisted Destination | Your Nexmo account is still in demo mode. While in demo mode you must add target numbers to your whitelisted destination list. Top-up your account to remove this limitation. |
| 32 | Signature And API Secret Disallowed | A signed request may not also present an `api_secret`.
| 33 | Number De-activated | The number you are trying to send messages to is de-activated and may not receive them.

## What else could have gone wrong?

If the value of `status` is zero and your message still did not arrive, then something went wrong during the actual delivery process. To know if your message reached the intended recipient, you need a [delivery receipt](/messaging/sms/guides/delivery-receipts) from the carrier.

