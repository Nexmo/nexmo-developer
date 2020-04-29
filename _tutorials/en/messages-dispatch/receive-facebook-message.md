---
title: Receive a Facebook message 
description: In this step you learn how to receive a Facebook message.
---

# Receive a Facebook message

First make sure your webhook server is running. It should correctly handle **both** [inbound message callbacks](/messages/code-snippets/inbound-message) and [message status callbacks](/messages/code-snippets/message-status)  returning at least a `200` to acknowledge each callback. You will need to have this in place so you can obtain the PSID of the Facebook User sending the inbound message. Once you have this you will be able to reply.

When a Facebook message is sent by a Facebook User to your Facebook Page a callback will be sent to your Inbound Message Webhook URL. An example callback is shown here:

```json
{
  "message_uuid":"aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "to":{
    "type":"messenger",
    "id":"0000000000000000"
  },
  "from":{
    "type":"messenger",
    "id":"1111111111111111"
  },
  "timestamp":"2020-01-01T14:00:00.000Z",
  "message":{
    "content":{
      "type":"text",
      "text":"Hello from Facebook Messenger!"
    }
  }
}
```

You need to extract the `from.id` value here as this is the ID that you need to send a reply.
