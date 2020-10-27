---
title: Send an Audio Message
meta_title: Send an audio message on WhatsApp using the Messages API
---

# Send an Audio Message

In this code snippet you learn how to send a WhatsApp audio message using the Messages API. For WhatsApp the maximum outbound media size is 64MB.

> **IMPORTANT:** If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`BASE_URL` | For production use the base URL is `https://api.nexmo.com/`. For sandbox testing the base URL is `https://messages-sandbox.nexmo.com/`.
`MESSAGES_API_URL` | For production use the Messages API endpoint is `https://api.nexmo.com/v0.1/messages`. For sandbox testing the Messages API endpoint is `https://messages-sandbox.nexmo.com/v0.1/messages`.
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Vonage. For sandbox testing the number is `14157386170`.
`TO_NUMBER` | The phone number you are sending the message to.
`AUDIO_URL` | The URL of the audio file to send.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-audio'
application:
  type: messages
  name: 'Send a WhatsApp audio'
```

## Try it out

When you run the code a WhatsApp audio message is sent to the destination number.
