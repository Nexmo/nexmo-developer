---
title: Send with Facebook Messenger
---

# Send with Facebook Messenger

In this Code Snippet you will see how to send a FaceBook message using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

```code_snippets
source: '_examples/messages/send-facebook-message'
application:
  type: messages
  name: 'Send a Facebook message'
```

## Try it out

When you run the code a FaceBook message is sent to the recipient.
