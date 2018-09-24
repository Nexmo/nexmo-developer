---
title: Send a WhatsApp Message
navigation_weight: 4
---

# Send a WhatsApp Message

In this building block you will see how to send a WhatsApp message using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`WHATSAPP_NUMBER` | The WhatsApp number that has been allocated to you by Nexmo.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```building_blocks
source: '_examples/olympus/send-whatsapp-message'
application:
  name: 'Send a WhatsApp message'
```

## Try it out

When you run the code a WhatsApp message will be sent to the destination number.
