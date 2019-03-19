---
title: Send a WhatsApp message with failover
---

# Send a WhatsApp message with failover

In this example you will send a WhatsApp message that fails over to sending an SMS.

In the Workflow object, message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

> **NOTE:** The first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.
`WHATSAPP_NUMBER` | Your WhatsApp Number.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-whatsapp-message-with-failover'
application:
  type: dispatch
  name: 'Send a WhatsApp message with failover'
```

## Try it out

When you run the code it will attempt to send a message via WhatsApp. If this fails then a message will be sent via SMS to the destination number.
