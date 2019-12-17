---
title: Send a File Message
meta_title: Send a File message with Facebook Messenger
---

# Send a File Message

In this code snippet you learn how to send a file message through Facebook Messenger using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FILE_URL` | The link to the file to send. Can be ZIP, CSV, PDF or any other type supported by Messenger.

```code_snippets
source: '_examples/messages/messenger/send-file'
application:
  type: messages
  name: 'Send a file message'
```

## Try it out

When you run the code a file message is sent to the Messenger recipient.
