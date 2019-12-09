---
title: Send a Contact
meta_title: Send a contact on WhatsApp using the Messages API
---

# Send a contact

In this code snippet you will see how to send a contact to WhatsApp using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
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
