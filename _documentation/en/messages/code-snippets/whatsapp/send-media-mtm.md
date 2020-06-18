---
title: Send a Media Message Template
meta_title: Send a WhatsApp Media Message Template using the Messages API
navigation_weight: 2
---

# Send a WhatsApp Media Message Template

In this code snippet you learn how to send a WhatsApp Media Message Template using the Messages API.

To send the Media Message Template you need to use the Messages custom object. The custom object takes a partial section of the original WhatsApp API request and sends it directly through to WhatsApp.

> **IMPORTANT:** If a customer messages you, you have 24 hours to respond to the customer with a free form message. After this period you must use a template message (MTM). If a customer has not messaged you first, then the first time you send a message to a user, WhatsApp requires that the message contains a template. This is explained in more detail in the [Understanding WhatsApp topic](/messages/concepts/whatsapp).

## Message format and length restrictions

WhatsApp Media Message Templates consist of a Header, Body and Footer structure. The Header contains the media, which can be text, location, video, image or file. The Body contains the text message. **This is currently limited to 1024 characters when displayed to the end user, so as to avoid the need for scrolling.** The Footer is optional and contains static text only.

> **NOTE:** The Header and Footer lengths are currently limited to 60 characters each and the Message body length is limited to 1024 characters.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`BASE_URL` | For production use the base URL is `https://api.nexmo.com/`. For sandbox testing the base URL is `https://messages-sandbox.nexmo.com/`.
`MESSAGES_API_URL` | For production use the Messages API endpoint is `https://api.nexmo.com/v0.1/messages`. For sandbox testing the Messages API endpoint is `https://messages-sandbox.nexmo.com/v0.1/messages`.
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo. For sandbox testing the number is `14157386170`.
`TO_NUMBER` | The phone number you are sending the message to.
`WHATSAPP_TEMPLATE_NAMESPACE` | The namespace ID found in your WhatsApp Business Account. Only templates created in your own namespace will work. Using an template with a namespace outside of your own results in an error code 1022 being returned. For sandbox testing the supported namespace is `9b6b4fcb_da19_4a26_8fe8_78074a91b584`.
`WHATSAPP_TEMPLATE_NAME` | The name of the template created in your WhatsApp Business Account. For sandbox testing the `verify` template is currently available. Refer to [this table](/messages/concepts/messages-api-sandbox#whatsapp-templates-for-use-with-the-messages-api-sandbox) for new templates as they become available.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-media-mtm'
application:
  type: messages
  name: 'Send a WhatsApp media message template'
```

## Try it out

When you run the code a WhatsApp Media Message Template is sent to the destination number.

## Further information

* [WhatsApp documentation for Media Message Templates](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/media-message-templates)
