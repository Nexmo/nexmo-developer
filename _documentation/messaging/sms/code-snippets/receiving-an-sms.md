---
title: Receive an SMS
navigation_weight: 5
---

# Receiving an SMS

To receive an SMS, you need to:

* [Rent a virtual number](/account/guides/numbers#rent-virtual-numbers) to receive messages
* [Create a webhook endpoint](before-you-begin#webhooks) using one of the code examples shown below
* [Configure the webhook in your Nexmo Dashboard](#configure-the-webhook-endpoint-in-your-nexmo-dashboard)


```code_snippets
source: '_examples/messaging/sms/receiving-an-sms'
```

## Configure the webhook endpoint in your Nexmo Dashboard

So that Nexmo knows how to access your webhook, you must configure it in your Nexmo account.

In the Code Snippets, the webhook is located at `/webhooks/inbound-sms`. If you are using Ngrok, the webhook you need to configure in your [Nexmo Dashboard API Settings page](https://dashboard.nexmo.com/settings) is of the form `https://demo.ngrok.io/webhooks/inbound-sms`. Replace `demo` with the subdomain provided by Ngrok and enter your endpoint in the field labeled **Webhook URL for Inbound Message**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/smsInboundWebhook.png
```

## Try it out

Now when you send your Nexmo number an SMS you should see it logged in your console. The message object contains the following properties:

```json
{
  "msisdn": "447700900001",
  "to": "447700900000",
  "messageId": "0A0000000123ABCD1",
  "text": "Hello world",
  "type": "text",
  "keyword": "Hello",
  "message-timestamp": "2020-01-01T12:00:00.000+00:00",
  "timestamp": "1578787200",
  "nonce": "aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "concat": "true",
  "concat-ref": "1",
  "concat-total": "3",
  "concat-part": "2",
  "data": "abc123",
  "udh": "abc123"
}
```
