---
title: Receive message status callback
navigation_weight: 6
---

# Message status

In this building block you will see how to receive message status updates.

> **NOTE:** Messages and Dispatch API does not support inbound SMS message and SMS delivery receipt callbacks via the application-specific webhooks. In order to receive callbacks for SMS message and SMS delivery receipts you need to set the [account-level webhooks for SMS](https://dashboard.nexmo.com/settings).


## Example

Ensure that your message status [webhook is set](/messages/building-blocks/configure-webhooks) in the Dashboard.

```building_blocks
source: '_examples/messages/message-status'
application:
  type: messages
  name: 'Message status'
```

## Try it out

The webhook will be invoked on changing message status and details printed to the console.
