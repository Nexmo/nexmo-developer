---
title: Sending Facebook Messenger messages with Messages API
products: messages-and-workflows-apis/messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the Facebook Messenger channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending Facebook Messenger messages with Messages API

You can use the Messages API to send and receive messages using Facebook Messenger.

Only an individual may have a Facebook Profile, whereas a business must have a Facebook Page.

A Facebook user must initiate communication using Facebook Messenger via the business's Facebook Page. A message from the business to the Facebook user will otherwise be refused.

Facebook Messenger uses its own form of IDs for the Facebook User and the Facebook Page :

* Facebook User (profile) - Page-Scoped ID (PSID)
* Facebook Page (business) - Page ID

The Facebook User will have a Page-scoped ID (PSID) and this is unique for each Facebook Profile. The business can only obtain the PSID of a user when the user sends a message to the business. In Facebook Messenger, the default is for the customer to initiate a conversation with a business.

In order to get started with Facebook Messenger you will need to link your business's Facebook Page to Nexmo. At this point Nexmo will provide you with your Facebook Page ID.

You can then test things by sending a message as a Facebook User to your own Facebook Page. At this point you will receive an inbound message webhook to your server with the PSID of the Facebook user. You can now use this PSID to send a message back to the user.

```partial
source: _partials/olympus/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Create a Facebook Page](#create-a-facebook-page) - You require a Facebook Account and a Facebook Page. 
2. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
3. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
4. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
5. [Link your Facebook Page to Nexmo](#link-your-facebook-page-to-nexmo)
6. [Receive a Facebook message](#Receive a Facebook message) - Receive a Facebook message from a Facebook User.
7. [Reply to a Facebook message](#reply-to-a-facebook-message) - Reply to the Facebook User.

## Create a Facebook Page

To use the Messages API with Facebook Messenger you must have a Facebook Account and a Facebook Page.

* [How do I create a Facebook Account?](https://en-gb.facebook.com/help/570785306433644/?helpref=hc_fnav)
* [How do I create a Facebook Page?](https://en-gb.facebook.com/help/104002523024878?helpref=about_content)

```partial
source: _partials/olympus/configure-webhook-urls.md
```

```partial
source: _partials/olympus/create-a-nexmo-application.md
```

```partial
source: _partials/olympus/generate-a-jwt.md
```

## Link your Facebook Page to Nexmo

Next you'll need to link your Facebook Page to Nexmo. This will allow Nexmo to handle the inbound messages and allow you to send messages from the Nexmo Messages API. This process needs to be authenticated by JWT. You will need to paste in the JWT you created in the previous step when prompted.

Click the following link when you have your JWT pasted to the clipboard and you are ready to link your Facebook Page to Nexmo:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

## Receive a Facebook message

When a Facebook message is sent by a Facebook User to your Facebook Page an event will be sent to your Inbound Message Webhook URL. An example event is shown here:

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

```building_blocks
source: '_examples/olympus/send-facebook-message'
```

## Further reading

* [Messages documentation](/messages-and-workflows-apis/messages/overview)
