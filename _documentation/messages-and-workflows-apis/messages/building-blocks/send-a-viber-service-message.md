---
title: Send a Viber Service Message
navigation_weight: 3
---

# Send a Viber Service Message

In this building block you will see how to send a Viber message using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to. 

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.

```building_blocks
source: '_examples/olympus/send-viber-message'
application:
  name: 'Send a Viber message'
```

## Try it out

When you run the code a Viber message will be sent to the destination number.