---
title: Send a Location
meta_title: Send a location on WhatsApp using the Messages API
---

# Send a Location

In this code snippet you learn how to send a location to WhatsApp using the Messages API. This uses Nexmo's [Custom object](/messages/concepts/custom-objects)] feature. Further information on the specific message format can be found in the WhatsApp developers [Location message](https://developers.facebook.com/docs/whatsapp/api/messages/others#location-messages) documentation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```code_snippets
source: '_examples/messages/whatsapp/send-location'
application:
  type: messages
  name: 'Send a location to WhatsApp'
```

## Try it out

When you run the code a WhatsApp location message is sent to the destination number. The location appears as a pin on a map within the WhatsApp message window.

## Further information

* [Custom objects](/messages/concepts/custom-objects)
* [WhatsApp documentation for send location](https://developers.facebook.com/docs/whatsapp/api/messages/others#location-messages)
