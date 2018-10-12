---
title: Inbound message
navigation_weight: 2
---

# Inbound message

In this building block you will see how to handle an inbound message.

## Example

Ensure that your inbound message [webhook is set](/messages/building-blocks/configure-webhooks) in the Dashboard.

```building_blocks
source: '_examples/messages/inbound-message'
application:
  use_existing: |
    If you do not have an application you can create one in the <a href="https://dashboard.nexmo.com/messages/create-application">Messages and Dispatch tab in the Dashboard</a>. Also make sure you <a href="https://developer.nexmo.com/messages/building-blocks/configure-webhooks">configure your webhooks</a>.
  name: 'Inbound message'
```

## Try it out

The webhook will be invoked on inbound message and the message details and data printed to the console.
