---
title: Send a Link Button
meta_title: Send a link button on WhatsApp using the Messages API
---

# Send a Link Button

In this code snippet you learn how to send a link style button on WhatsApp. This uses Vonage's [custom object](/messages/concepts/custom-objects) facility. You can reference the WhatsApp developer documentation for the specifics of the [message format](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates).

When the message recipient clicks on the link button, they will be prompted for permission to continue to the target link.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- WHATSAPP_NUMBER
- TO_NUMBER.MESSAGES
- WHATSAPP_TEMPLATE_NAMESPACE
- WHATSAPP_TEMPLATE_NAME
- HEADER_IMAGE_URL.WHATSAPP.MESSAGES
```

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-button-link'
application:
  type: messages
  name: 'Send a link button to WhatsApp'
```

## Try it out

When you run the code a WhatsApp message containing a link button is sent to the recipient. In this example the button is a link to package tracking information.

## Further information

-   [Custom objects](/messages/concepts/custom-objects)
-   [WhatsApp documentation for Link Button](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/interactive-message-templates)
