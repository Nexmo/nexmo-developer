---
title: Send a Contact
meta_title: Send a contact on WhatsApp using the Messages API
---

# Send a Contact

In this code snippet you learn how to send a contact to WhatsApp using the Messages API. This uses Nexmo's [Custom object](/messages/concepts/custom-objects)] feature. Further information on the specific message format can be found in the WhatsApp developers [Contacts message](https://developers.facebook.com/docs/whatsapp/api/messages/others#contacts-messages) documentation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
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
