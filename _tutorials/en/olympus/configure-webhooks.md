---
title: Learn how to configure your webhooks 
description: Learn how to configure your webhooks to receive messages from your chosen channel
---

There are at least two webhooks you must configure:

* Message Status webhook
* Inbound Message webhook

When messages status updates are generated, such as `delivered`, `rejected` or `accepted`, callbacks will be received on the _Message Status_ webhook URL.

When an inbound message is received, a callback with message payload is invoked on the _Inbound Message_ webhook URL.

> **IMPORTANT:** Both webhook URLs should be configured. At the very least your webhook handlers should return 200 responses for both Inbound Message and Message Status callbacks. This ensures potential [callback queuing](#callback-queue) issues are avoided.

### To configure the webhook URLs

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Messages and Dispatch](https://dashboard.nexmo.com/messages/create-application).

> **TIP:** If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

Enter your Webhook URLs in the fields labeled **Status URL** and **Inbound URL**.

The values you enter for webhook URLs depends on where your webhook server is located. If your server was running on port 3000 on `example.com` your webhook URLs might be:

Webhook | URL
---|---
Status URL | `https://www.example.com:3000/webhooks/message-status`
Inbound URL | `https://www.example.com:3000/webhooks/inbound-message`

> **NOTE:** The default method of `POST` should be used for both of the webhook URLs.

### Inbound SMS webhooks

Messages API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks described in the previous section. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

### Callback queue

Please note that callbacks emanating from Nexmo, such as those on your Message Status webhook URL and Inbound Message URL, are queued by Nexmo on a per-account basis, **not** a per-application basis.

To avoid callbacks stalling the callback queue, please ensure that all applications acknowledge callbacks with a 200 response. Further, it is advisable to cease activity on a test application 24 hours before deleting it, or removing webhook configuration, otherwise it could potentially leave callbacks in your callback queue that will not be acknowledged, and therefore result in delays on callbacks destined for your production applications.
