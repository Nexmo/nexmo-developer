---
title: Inbound Message Webhook
navigation_weight: 5
---

# Inbound Message Webhook

In this code snippet you learn how to receive an inbound message using the inbound message webhook.

> **NOTE:** Messages API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

## Example

Ensure that your inbound message [webhook is set](/messages/code-snippets/configure-webhooks) in the Dashboard.  As a minimum your handler must return a 200 status code to avoid unnecessary callback queuing. Make sure your webhook server is running before testing your Messages application.

```code_snippets
source: '_examples/messages/inbound-message'
application:
  type: messages
  name: 'Inbound message'
```

## Try it out

The webhook is invoked on receipt of an [inbound message](https://developer.nexmo.com/api/messages-olympus#inbound-message) and the message details and data are printed to the console.
