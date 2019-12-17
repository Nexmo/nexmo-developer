---
title: Send an Image Message
meta_title: Send an image message on WhatsApp using the Messages API
---

# Send an Image Message

In this code snippet you learn how to send a WhatsApp image message using the Messages API. For WhatsApp the maximum outbound media size is 64MB.

> **IMPORTANT:** If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.
`IMAGE_URL` | The URL of the image to send.
`IMAGE_CAPTION` | The text describing the image being sent.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-image'
application:
  type: messages
  name: 'Send a WhatsApp image'
```

## Try it out

When you run the code a WhatsApp image message is sent to the destination number.
