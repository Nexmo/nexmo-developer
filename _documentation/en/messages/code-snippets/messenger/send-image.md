---
title: Send an Image Message
meta_title: Send an Image message with Facebook Messenger
---

# Send an Image Message

In this code snippet you learn how to send an image message through Facebook Messenger using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- FB_SENDER_ID.MESSAGES
- FB_RECIPIENT_ID
- IMAGE_URL.MESSENGER.MESSAGES
```

```code_snippets
source: '_examples/messages/messenger/send-image'
application:
  type: messages
  name: 'Send an image message'
```

## Try it out

When you run the code an image message is sent to the Messenger recipient.
