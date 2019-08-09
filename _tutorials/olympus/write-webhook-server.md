---
title: Create a Messages webhook server
description: Receive an inbound message with a webhook server
---

In this code snippet you will see how to handle an inbound message.

> **NOTE:** Messages API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

## Example

Ensure that your inbound message [webhook is set](/tasks/olympus/configure-webhooks) in the Dashboard.  As a minimum your handler must return a 200 status code to avoid unnecessary callback queuing. Make sure your webhook server is running before testing your Messages application.

```code_snippets
source: '_examples/messages/webhook-server'
```
