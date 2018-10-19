---
title: Receive message status callback
navigation_weight: 3
---

# Message status

In this building block you will see how to receive message status updates.

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
