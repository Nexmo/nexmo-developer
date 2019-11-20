---
title: Send an Image Message
meta_title: Send an image message on Viber using the Messages API
navigation_weight: 2
---

# Send an image Message

In this code snippet you will see how to send a Viber image message using the Messages API.

> **NOTE:** It is important that you read [this information about Viber accounts and messaging](/messages/concepts/viber) before trying this code snippet.

For a step-by-step guide to this topic, you can read our tutorial [Sending Viber Service messages with the Messages API](/tutorials/sending-viber-service-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to.
`IMAGE_URL` | The URL of the image you want to send.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/viber/send-image'
application:
  type: messages
  name: 'Send a Viber image message'
```

## Try it out

When you run the code a Viber image message is sent to the destination number.
