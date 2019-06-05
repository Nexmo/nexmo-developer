---
title: Send an Audio Message
meta_title: Send an Audio message with Facebook Messenger
---

# Send an Audio Message

In this code snippet you will see how to send an Audio message through Facebook Messenger using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`AUDIO_URL` | The link to the audio file to send. Must be MP3 format for Messenger.

```code_snippets
source: '_examples/messages/messenger/send-audio'
application:
  type: messages
  name: 'Send an audio message'
```

## Try it out

When you run the code an audio message is sent to the Messenger recipient.
