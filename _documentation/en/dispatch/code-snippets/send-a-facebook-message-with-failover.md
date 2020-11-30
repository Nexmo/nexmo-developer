---
title: Send a Facebook message with failover
---

# Send a Facebook message with failover

In this example you will send a Facebook Messenger message that fails over to sending an SMS. In the Workflow object message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook message with failover](/tutorials/sending-facebook-message-with-failover).

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- VONAGE_APPLICATION_ID
- FROM_NUMBER.DISPATCH
- TO_NUMBER.DISPATCH
- FB_SENDER_ID
- FB_RECIPIENT_ID
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-facebook-message-with-failover'
application:
  type: dispatch
  name: 'Send a message with failover'
```

## Try it out

When you run the code it will attempt to send a message via Facebook Messenger. This will fail and then a message will be sent via SMS to the destination number.
