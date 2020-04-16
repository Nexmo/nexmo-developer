---
title: Send a Contact
meta_title: Send a contact on WhatsApp using the Messages API
---

# Send a Contact

In this code snippet you learn how to send a contact to WhatsApp using the Messages API. This uses Nexmo's [Custom object](/messages/concepts/custom-objects) feature. Further information on the specific message format can be found in the WhatsApp developers [Contacts message](https://developers.facebook.com/docs/whatsapp/api/messages/others#contacts-messages) documentation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`BASE_URL` | For production use the base URL is `https://api.nexmo.com/`. For sandbox testing the base URL is `https://messages-sandbox.nexmo.com/`.
`MESSAGES_API_URL` | For production use the Messages API endpoint is `https://api.nexmo.com/v0.1/messages`. For sandbox testing the Messages API endpoint is `https://messages-sandbox.nexmo.com/v0.1/messages`.
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo. For sandbox testing the number is `14157386170`.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-contact'
application:
  type: messages
  name: 'Send a contact to WhatsApp'
```

## Try it out

When you run the code a WhatsApp contact message is sent to the destination number. In WhatsApp you can view the contact details and add to address book if required.

## Further information

* [Custom objects](/messages/concepts/custom-objects)
* [WhatsApp documentation for send contact](https://developers.facebook.com/docs/whatsapp/api/messages/others#contacts-messages)
