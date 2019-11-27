---
title: Send a Video Message
meta_title: Send a Video message with Facebook Messenger
---

# Send a Video Message

In this code snippet you will see how to send a video message through Facebook Messenger using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`VIDEO_URL` | The link to the video to send. Messenger supports MP4 (`.mp4`) file format only.

```code_snippets
source: '_examples/messages/messenger/send-video'
application:
  type: messages
  name: 'Send a video message'
```

## Try it out

When you run the code a video message is sent to the Messenger recipient.
