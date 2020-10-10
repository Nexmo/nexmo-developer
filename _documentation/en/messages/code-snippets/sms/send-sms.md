---
title: Send an SMS
meta_title: Send an SMS using the Messages API
---

# Send an SMS

In this code snippet you will see how to send an SMS using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending SMS messages with the Messages API](/tutorials/sending-sms-messages-with-messages-api).

## Delivery receipts

The webhook used for the delivery receipt will depend on the type of authentication used:

Authentication type used | Webhook used for delivery receipt
----|----
Basic Auth | [account-level webhook](https://dashboard.nexmo.com/settings) is used for delivery receipt.
JWT Auth | [application-level webhook](https://dashboard.nexmo.com/applications) is used for delivery receipt / status.

> Reception of delivery receipts depends on availability of network support.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`VONAGE_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

```code_snippets
source: '_examples/messages/sms/send-sms'
application:
  type: messages
  name: 'Send an SMS'
```

## Try it out

When you run the code a message is sent to the destination number.
