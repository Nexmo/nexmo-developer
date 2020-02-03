---
title: Sending Facebook Messenger messages with the Messages API
products: messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the Facebook Messenger channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending Facebook Messenger messages with the Messages API

You can use the Messages API to send and receive messages using Facebook Messenger.

Before continuing with this tutorial you should review the information on [Understanding Facebook messaging](/messages/concepts/facebook).

```partial
source: _partials/reusable/prereqs.md
```

> **NOTE:** This tutorial assumes you have already created a Facebook Profile and a Facebook Page.

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Link your Facebook Page to Nexmo](#part-1-link-your-facebook-page-to-your-nexmo-account)
2. [Create a Nexmo Application](#create-a-nexmo-application)
3. [Receive a Facebook message](#receive-a-facebook-message)
4. [Reply to a Facebook message](#reply-to-a-facebook-message)

```partial
source: _partials/reusable/link-facebook-to-nexmo.md
```

```partial
source: _partials/reusable/create-a-nexmo-application.md
```

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

## Further reading

* [Messages documentation](/messages/overview)
