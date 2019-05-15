---
title: Send an SMS
meta_title: Send an SMS using the Messages API
---

# Send an SMS

In this code snippet you will see how to send an SMS using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending SMS messages with the Messages API](/tutorials/sending-sms-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/messages/sms/send-sms'
application:
  type: messages
  name: 'Send an SMS'
```

## Try it out

When you run the code a message is sent to the destination number.
