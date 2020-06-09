---
title: Delivery receipts
description: How to request a delivery receipt (DLR) from the carrier.
navigation_weight: 4
---

# Delivery receipts

When you make a successful request to the SMS API, it returns an array of `message` objects, one for each message. Ideally these will have a `status` of `0`, indicating success. But this does not mean that your message has reached your recipients. It only means that your message has been successfully queued for sending.

Nexmo's [adaptive routing](https://help.nexmo.com/hc/en-us/articles/218435987-What-is-Nexmo-Adaptive-Routing-) then identifies the best carrier for your message. When the selected carrier has delivered the message, it returns a *delivery receipt* (DLR).

To receive DLRs in your application, you must provide a [webhook](/concepts/guides/webhooks) for Nexmo to send them to. Alternatively, you could use the [Reports API](/reports/overview) to periodically download your records, including per-message delivery status.

> **Note**: In most situations, a DLR is a reliable indicator that a message was delivered. However, it is not an absolute guarantee. See [how delivery receipts work](#how-delivery-receipts-work).

## How delivery receipts work

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

Delivery receipts are either:

* **Carrier** - returned when the service provider receives the message
* **Handset** - returned when the user's handset receives the message

Not all DLRs guarantee that the target received your message. Some delivery receipts represent successful completion of just one stage in the delivery process, such as passing the message to another operator. Other delivery receipts are fakes. Because of this, Nexmo cannot completely guarantee that a DLR is accurate. It depends on the [countries](/messaging/sms/guides/country-specific-features) you are sending messages to and the providers involved.

If your message is longer than can be sent in a single SMS, the messages are [concatenated](/messaging/sms/guides/concatenation-and-encoding). You should receive a carrier DLR for each part of the concatenated SMS. Handset DLRs for a concatenated message are delayed. This is because the target handset has to process each part of the concatenated message before it can acknowledge receipt of the full message.

## Understanding the delivery receipt

This is a typical DLR:

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

The most important fields are `status` and `err-code` as these tell you whether your message was delivered and, if not, what went wrong.

### DLR status messages

The `status` field in the DLR tells you if your SMS was delivered successfully. Possible values are:

| `status`  | Description  |
|---|---|
| `accepted` | Message has been accepted for delivery, but has not yet been delivered |
| `delivered`  | Message has been delivered  |
| `buffered` | Message has been buffered for later delivery  |
| `expired`  | Message was held at downstream carrier's retry scheme and could not be delivered within the expiry time |
| `failed` | Message not delivered |
| `rejected` | Downstream carrier refuses to deliver message |
| `unknown`  | No useful information available |


### DLR error codes

The `err-code` field in the DLR provides more detailed information and can help troubleshoot a failed delivery. A non-zero code indicates that the message could not be delivered.

| `err-code` | Meaning | Description |
|---|---|---|
| 0 | Delivered  | Message was delivered successfully |
| 1 | Unknown  | Message was not delivered, and no reason could be determined |
| 2 | Absent Subscriber - Temporary | Message was not delivered because handset was temporarily unavailable - retry | 
| 3 | Absent Subscriber - Permanent | The number is no longer active and should be removed from your database  |
| 4 | Call Barred by User | This is a permanent error:the number should be removed from your database and the user must contact their network operator to remove the bar |
| 5 | Portability Error | There is an issue relating to portability of the number and you should contact the network operator to resolve it |
| 6 | Anti-Spam Rejection  | The message has been blocked by a carrier's anti-spam filter |
| 7 | Handset Busy | The handset was not available at the time the message was sent - retry |
| 8 | Network Error | The message failed due to a network error - retry  |
| 9 | Illegal Number | The user has specifically requested not to receive messages from a specific service |
| 10 | Illegal Message | There is an error in a message parameter, e.g. wrong encoding flag |
| 11 | Unroutable  | Nexmo cannot find a suitable route to deliver the message - contact <mailto:support@nexmo.com> |
| 12 | Destination Unreachable | A route to the number cannot be found - confirm the recipient's number  |
| 13 | Subscriber Age Restriction | The target cannot receive your message due to their age  |
| 14 | Number Blocked by Carrier | The recipient should ask their carrier to enable SMS on their plan |
| 15 | Prepaid Insufficient Funds | The recipient is on a prepaid plan and does not have enough credit to receive your message |
| 99 | General Error | Typically refers to an error in the route - contact <mailto:support@nexmo.com> |

> The other fields in the DLR are explained in the [API Reference](/api/sms#delivery-receipt).

## Using the SMS API in campaigns

Before you start your messaging campaign, check the [country specific features guide](/messaging/sms/guides/country-specific-features) for the countries you are sending to. If the country you are sending to does not supply reliable DLRs, use the [Conversion API](/messaging/conversion-api/overview) to provide Nexmo with more data points and ensure the best routing.

Optionally, you can identify specific customers or campaigns by including a reference with each message you send. These are included in the delivery receipt. Pass your chosen reference into the request by specifying a `client-ref` parameter of up to 40 characters.

## Other resources

* [Webhooks Guide](/concepts/guides/webhooks) — a detailed guide to how to use webhooks with Nexmo's platform
* [Why was my SMS not delivered?](https://help.nexmo.com/hc/en-us/articles/204016013-Why-was-my-SMS-not-delivered-) - useful troubleshooting tips
