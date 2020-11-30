---
title: Send a Message Template
meta_title: Send a message template with Facebook Messenger
---

# Send a Message Template

In this code snippet you learn how to send a Facebook message template using a [custom object](/messages/concepts/custom-objects) with the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- FB_SENDER_ID.MESSAGES
- FB_RECIPIENT_ID
- LOGO_IMAGE_URL
- HEADER_IMAGE_URL
- ABOVE_BAR_CODE_IMAGE_URL
```

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