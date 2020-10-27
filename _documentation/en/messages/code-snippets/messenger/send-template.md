---
title: Send a Message Template
meta_title: Send a message template with Facebook Messenger
---

# Send a Message Template

In this code snippet you learn how to send a Facebook message template using a [custom object](/messages/concepts/custom-objects) with the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`BASE_URL` | For production use the base URL is `https://api.nexmo.com/`. For sandbox testing the base URL is `https://messages-sandbox.nexmo.com/`.
`MESSAGES_API_URL` | For production use the Messages API endpoint is `https://api.nexmo.com/v0.1/messages`. For sandbox testing the Messages API endpoint is `https://messages-sandbox.nexmo.com/v0.1/messages`.
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL. For sandbox testing this is `107083064136738`.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`LOGO_IMAGE_URL` | An optional logo image.
`HEADER_IMAGE_URL` | An optional header image.
`ABOVE_BAR_CODE_IMAGE_URL` | An optional image for above the bar code.

```code_snippets
source: '_examples/messages/messenger/send-template'
application:
  type: messages
  name: 'Send a custom object Facebook message'
```

## Try it out

When you run the code a Facebook message template is sent to the recipient. In this example the message is an airline boarding pass.

## Further information

* [Custom Objects](/messages/concepts/custom-objects)
* [Sending Facebook Messenger messages with the Messages API](/use-cases/sending-facebook-messenger-messages-with-messages-api)
* [Facebook Message Templates documentation](https://developers.facebook.com/docs/messenger-platform/send-messages/templates/)