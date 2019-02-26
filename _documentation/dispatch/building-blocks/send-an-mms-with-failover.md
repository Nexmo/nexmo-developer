---
title: Send an MMS with failover
---

# Send an MMS with failover

In this example you will send an MMS that can fail over to sending an SMS.

In the Workflow object, message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

> **NOTE:** MMS only supports US Short Codes.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the MMS from (US Short Code only).
`TO_NUMBER` | The phone number you are sending the MMS to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```building_blocks
source: '_examples/dispatch/send-mms-with-failover'
application:
  type: dispatch
  name: 'Send an MMS with failover'
```

## Try it out

When you run the code it will attempt to send an MMS. If this fails, for example because the recipient is on T-Mobile, then a message will be sent via SMS to the destination number.
