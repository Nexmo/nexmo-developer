---
title: Receive an inbound message
navigation_weight: 2
---

# Inbound message

In this building block you will see how to handle an inbound message.

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
