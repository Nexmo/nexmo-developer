---
title: Send a Custom Object Message
meta_title: Send a custom object message with Facebook Messenger
---

# Send a Custom Object Message

In this code snippet you learn how to send a Facebook [custom object](/messages/concepts/custom-objects) message using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`LOGO_IMAGE_URL` | An optional logo image.
`HEADER_IMAGE_URL` | An optional header image.
`ABOVE_BAR_CODE_IMAGE_URL` | An optional image for above the bar code.

```code_snippets
source: '_examples/messages/messenger/send-custom'
application:
  type: messages
  name: 'Send a custom object Facebook message'
```

## Try it out

When you run the code a Facebook message is sent to the recipient containing a custom object. In this case the object is an airline boarding pass.

## Further information

* [Sending Facebook Messenger messages with the Messages API](/use-cases/sending-facebook-messenger-messages-with-messages-api)
