---
title: Send an SMS with failover
---

# Send an SMS with failover

In this example you will send an SMS that can fail over to sending an SMS.

In the Workflow object, message objects can be placed in any order to suit your use case. Each message object must contain a failover object, except for the last message, as there are no more message objects to failover to.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the SMS from.
`TO_NUMBER_1` | The phone number you are sending the SMS to.
`TO_NUMBER_2` | The phone number of the second phone. In this example, the workflow will failover to this number if the first message is not read in 60 seconds.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/dispatch/send-sms-with-failover'
application:
  type: dispatch
  name: 'Send an SMS with failover'
```

## Try it out

When you run the code it will attempt to send an SMS to phone 1. If this fails, then a message will be sent via SMS to phone 2.

> **NOTE:** Correct functioning of this code snippet will depend on the support provided by the underlying network. For example, availability of delivery and read receipts.
