---
title: Send with Facebook Messenger
navigation_weight: 2
---

# Send with Facebook Messenger

In this building block you will see how to send a FaceBook message using the Messages API.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`SENDER_ID` | Your Page ID. The `SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`RECIPIENT_ID` | The PSID of the user you want to reply to. The `RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

```building_blocks
source: '_examples/olympus/send-facebook-message'
application:
  name: 'Send a Facebook message'
```

## Try it out

When you run the code a FaceBook message will be sent to the recipient.