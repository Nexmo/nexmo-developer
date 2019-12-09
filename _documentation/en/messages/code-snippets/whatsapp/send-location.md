---
title: Send a Location
meta_title: Send a location on WhatsApp using the Messages API
navigation_weight: 9
---

# Send a location

In this code snippet you will see how to send a location to WhatsApp using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
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
