---
title: Send a Facebook message 
description: In this step you learn how to send a Facebook message ... 
---

# Send a Facebook message 

Sending a Facebook message ....TBD.

## Receive a Facebook message

First make sure your webhook server is running. It should correctly handle **both** [inbound message callbacks](/messages/code-snippets/inbound-message) and [message status callbacks](/messages/code-snippets/message-status)  returning at least a 200 to acknowledge each callback. You will need to have this in place so you can obtain the PSID of the Facebook User sending the inbound message. Once you have this you will be able to reply.

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

You will need to extract the `from.id` value here as this is the ID that you will need to send a reply.

## Reply to a Facebook message

You can then use the Messages API to respond to the inbound message received from the Facebook User.

Replace the following variables in the example below with actual values:

Key | Description
-- | --
`FB_SENDER_ID` | Your Page ID. The `FB_SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`FB_RECIPIENT_ID` | The PSID of the user you want to reply to. The `FB_RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

## Example

```code_snippets
source: '_examples/messages/messenger/send-text'
```

> **TIP:** If testing using Curl you will need a JWT. You can see how to create one in the documentation on [creating a JWT](/messages/code-snippets/before-you-begin#generate-a-jwt).
