---
title: Send an Audio Message
meta_title: Send an audio message on WhatsApp using the Messages API
---

# Send an Audio Message

In this code snippet you learn how to send a WhatsApp audio message using the Messages API. For WhatsApp the maximum outbound media size is 64MB.

> **IMPORTANT:** If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- WHATSAPP_NUMBER
- TO_NUMBER.MESSAGES
- AUDIO_URL
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-audio'
application:
  type: messages
  name: 'Send a WhatsApp audio'
```

## Try it out

When you run the code a WhatsApp audio message is sent to the destination number.
