---
title: Send an MMS
---

# Send an MMS

In this building block you will see how to send an MMS using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```building_blocks
source: '_examples/messages/send-mms'
application:
  name: 'Send an MMS'
```

## Try it out

When you run the code an MMS message will be sent to the destination number.
