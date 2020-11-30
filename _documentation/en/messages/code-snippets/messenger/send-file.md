---
title: Send a File Message
meta_title: Send a File message with Facebook Messenger
---

# Send a File Message

In this code snippet you learn how to send a file message through Facebook Messenger using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- FB_SENDER_ID.MESSAGES
- FB_RECIPIENT_ID
- FILE_URL.MESSENGER.MESSAGES
```

```code_snippets
source: '_examples/messages/messenger/send-file'
application:
  type: messages
  name: 'Send a file message'
```

## Try it out

When you run the code a file message is sent to the Messenger recipient.
