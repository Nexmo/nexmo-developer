---
title: Message status
navigation_weight: 3
---

# Message status

In this building block you will see how to receive message status updates.

## Example

Ensure that your message status [webhook is set](/messages/building-blocks/configure-webhooks) in the Dashboard.

```building_blocks
source: '_examples/messages/message-status'
application:
  use_existing: |
    If you do not have an application you can create one in the <a href="https://dashboard.nexmo.com/messages/create-application">Messages and Dispatch tab in the Dashboard</a>. Also make sure you <a href="https://developer.nexmo.com/messages/building-blocks/configure-webhooks">configure your webhooks</a>.
  name: 'Message status'
```

## Try it out

The webhook will be invoked on changing message status and details printed to the console.
