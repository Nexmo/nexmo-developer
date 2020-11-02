---
title: Message Status Webhook
navigation_weight: 6
---

# Message Status Webhook

In this code snippet you learn how to receive message status updates using the message status webhook.

> **NOTE:** Messages API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

> **NOTE:** Messages API supports [signed webhooks](/messages/concepts/signed-webhooks) so you can verify a request is coming from Vonage and its payload has not been tampered with during transit.

## Example

Ensure that your message status [webhook is set](/messages/code-snippets/configure-webhooks) in the Dashboard. As a minimum your handler must return a 200 status code to avoid unnecessary callback queuing. Make sure your webhook server is running before testing your Messages application.

```code_snippets
source: '_examples/messages/message-status'
application:
  type: messages
  name: 'Message status'
```

## Try it out

The webhook is invoked on a change in status for an outbound message sent from Vonage. The message status is also printed to the console.

The format of the message status `POST` request can be found in the [Message Status](/api/messages-olympus#message-status) section of the [API reference](/api/messages-olympus#overview).
