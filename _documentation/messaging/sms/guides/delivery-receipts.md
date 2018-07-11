---
title: Delivery receipts
---

# Delivery receipts

When Nexmo sends an SMS to a carrier, the carrier should return a delivery receipt (DLR). Carriers send delivery receipts at a moment of their choice, they do not have to wait for delivery confirmation.

## How delivery receipts work

```js_sequence_diagram
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

* **Carrier** - returned when the SMS is received by the telecommunications service providers.
* **Handset** - returned when the message is received on your user's handset.

If your message is longer than a single SMS, carriers should send a DLR for each part of the concatenated SMS. Handset delivery receipts for a concatenated message are delayed. This is because each part of the concatenated message takes about 10 seconds to be processed by the handset.

In practice, some carriers either do not send the delivery receipt or send a fake. Depending on the country you are sending to, Nexmo cannot be 100% certain that a *successfully delivered* delivery receipt means that the message reached your user.

When sending messages using the [Nexmo SMS API](https://developer.nexmo.com/api/sms#delivery-receipt) or Nexmo client library, you can specify the `client-ref` parameter. This allows you to assign a customer-specific reference code to each SMS sent. This reference code will then be included in the delivery receipt so you can identify specific clients.

## Country specific

Before you start your messaging campaign:

1. Check the [Country Specific Features](/messaging/sms/guides/country-specific-features) for the countries you are sending to.
2. If the country you are sending to does not supply reliable DLRs, use [Conversion API](/messaging/conversion-api/overview) so Nexmo has more data points to ensure the best routing.

Once Nexmo receives a delivery receipt, we will send it to you using a [webhook](/concepts/guides/webhooks).

## Implementing a delivery receipt webhook

To get a delivery receipt, you will need to implement a webhook endpoint the API can send the payload to.

```tabbed_content
source: '_examples/messaging/sms/delivery-receipts/'
```

## Make your machine publicly available

If you are running the code above on your desktop/laptop computer, you will need to make your computer publicly available so Nexmo can send the delivery receipt to it. We recommend you try [ngrok](https://ngrok.com) to do this quite easily.

See [this blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) for more details about how to use ngrok.

## Tell Nexmo about your webhook endpoint

Now that your webhook endpoint is running, you need to tell Nexmo to send delivery receipts to this address.

The webhook URL is the forwarding address given to you by ngrok combined with `/webhooks/delivery-receipt`.

For instance: `https://demo.ngrok.io/webhooks/delivery-receipt`

Paste your webhook URL into the [settings section of Nexmo Dashboard](https://dashboard.nexmo.com/settings)
in the field marked labelled "Webhook URL for Delivery Receipt" and press 'Save Changes'.

```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
image: public/assets/screenshots/da5f952d465355c19eb888fa1049844b31e090c2.png
```

## Send a message

We are now ready to [send the message](/messaging/sms/building-blocks/send-an-sms), you can do this with the [Nexmo CLI](/tools) as such:

```
$ nexmo sms 447700900000 "A text message sent using the Nexmo SMS API"
```

Shortly after your server should print the parameters:

```json
{
  "msisdn": "447700900000",
  "to": "Nexmo CLI",
  "network-code": "12345",
  "messageId": "<REDACTED>",
  "price": "0.03330000",
  "status": "delivered",
  "scts": "1703291538",
  "err-code": "0",
  "message-timestamp": "2020-01-01 14:00:00"
}
```

## See also

* [Webhooks Guide](/concepts/guides/webhooks) — a detailed guide to how to use webhooks with Nexmo's platform
