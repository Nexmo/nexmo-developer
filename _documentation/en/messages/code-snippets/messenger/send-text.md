---
title: Send a Text Message
meta_title: Send a Text message with Facebook Messenger
---

# Send a Text Message

In this code snippet you learn how to send a Facebook message using the Messages API.

For a step-by-step guide to this topic, you can read our tutorial [Sending Facebook Messenger messages with the Messages API](/tutorials/sending-facebook-messenger-messages-with-messages-api).

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- BASE_URL.MESSAGES
- MESSAGES_API_URL
- FB_SENDER_ID.MESSAGES
- FB_RECIPIENT_ID
```

```code_snippets
source: '_examples/messages/messenger/send-text'
application:
  type: messages
  name: 'Send a Facebook message'
```

## Try it out

When you run the code a Facebook message is sent to the recipient.
