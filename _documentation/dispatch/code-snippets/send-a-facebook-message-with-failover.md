---
title: Send a Facebook message with failover
---

# Send a Facebook message with failover

In this example you will send a Facebook Messenger message that fails over to sending an SMS. In the Workflow object message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook message with failover](/tutorials/sending-facebook-message-with-failover).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-facebook-message-with-failover'
application:
  type: dispatch
  name: 'Send a message with failover'
```

## Try it out

When you run the code it will attempt to send a message via FaceBook Messenger. This will fail and then a message will be sent via SMS to the destination number.
