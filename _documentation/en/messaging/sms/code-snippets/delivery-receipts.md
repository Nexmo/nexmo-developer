---
title: Delivery Receipts
description: How to retrieve SMS delivery receipts
navigation_weight: 4
---

# Delivery Receipts

You can verify that a message you sent using Nexmo's SMS API reached your customer by requesting a [delivery receipt](/messaging/sms/guides/delivery-receipts) from the carrier.

> **NOTE:** Not all networks and countries support delivery receipts. You can check our knowledge base for some further information on what you [might receive](https://help.nexmo.com/hc/en-us/articles/204014863) if your network does not support delivery receipts. For detailed information on delivery receipts see our [documentation](/messaging/sms/guides/delivery-receipts).

To access the delivery receipt, you need to:

* [Create a webhook endpoint](/messaging/sms/code-snippets/before-you-begin#webhooks) using one of the code examples shown below
* [Configure the webhook endpoint in your Nexmo Dashboard](#configure-the-webhook-endpoint-in-your-nexmo-dashboard)

> **NOTE:** After you send a message there may be a delay before you receive the delivery receipt.

```code_snippets
source: '_examples/messaging/sms/delivery-receipts'
```

## Configure the webhook endpoint in your Nexmo Dashboard

So that Nexmo knows how to access your webhook, you must configure it in your Nexmo account.

In the code snippets, the webhook is located at `/webhooks/delivery-receipt`. If you are using Ngrok, the webhook you need to configure in your [Nexmo Dashboard API Settings page](https://dashboard.nexmo.com/settings) is of the form `https://demo.ngrok.io/webhooks/delivery-receipt`. Replace `demo` with the subdomain provided by Ngrok and enter your endpoint in the field labeled **Webhook URL for Delivery Receipts**:

```screenshot
script: app/screenshots/webhook-url-for-delivery-receipt.js
image: public/assets/screenshots/smsDLRsettings.png
```

## Try it out

[Send a message](send-an-sms) to a mobile number and, if the network supports it, you will receive a delivery receipt in the following format:

```json
{
  "err-code": "0",
  "message-timestamp": "2020-10-25 12:10:29",
  "messageId": "0B00000127FDBC63",
  "msisdn": "447700900000",
  "network-code": "23410",
  "price": "0.03330000",
  "scts": "1810251310",
  "status": "delivered",
  "to": "Nexmo CLI"
}
```

> **NOTE:** After you send a message there may be a delay before you receive the delivery receipt.

## More information

* [SMS Delivery Receipt documentation](/messaging/sms/guides/delivery-receipts)
