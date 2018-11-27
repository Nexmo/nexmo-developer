---
title: Receive an inbound message
navigation_weight: 5
---

# Inbound message

In this building block you will see how to handle an inbound message.

> **NOTE:** Messages and Dispatch API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).

## Example

Ensure that your inbound message [webhook is set](/messages/building-blocks/configure-webhooks) in the Dashboard.

```building_blocks
source: '_examples/messages/inbound-message'
application:
  type: messages
  name: 'Inbound message'
```

## Try it out

The webhook will be invoked on inbound message and the message details and data printed to the console.
