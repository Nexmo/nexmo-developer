---
title: Overview
---

# Messages Overview [Developer Preview]

The Messaging API is a single API that enables easy integration with various communication channels such as: SMS, Facebook Messenger and Viber.

```
curl -X POST https://api.nexmo.com/beta/messages \
  -H 'Authorization: Basic base64(API_KEY:API_SECRET)'\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "from": { "type": "sms", "number": "TO_NUMBER" },
    "to": { "type": "sms", "number": "FROM_NUMBER" },
    "message": {
      "content": {
        "type": "text",
        "text": "This is an SMS sent from the Messages API"
      }
    }
  }'
```

This API is currently in Developer Preview and you will need to [request access](https://www.nexmo.com/products/messages) to use it.

During Developer Preview we will expand the capabilities of the API. Please visit the API Reference for a comprehensive breakdown and on high level we currently support:

* Outbound text messages on SMS, Viber Service Messages and Facebook Messenger.
* Outbound media messages on Facebook Messenger.
* Inbound text, media and location messages on Facebook Messenger.

There may be bugs and quirks so we'd welcome your feedback - any suggestions you make help us shape the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Messages API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

## Contents

In this document you can learn about:

* [Concepts](#concepts)
* [How to Get Started with Messages](#getting-started)
* [Building Blocks](#building-blocks)
* [Guides](#guides)
* [Reference](#reference)
* [Notices](#notices)

## Concepts

To use the Messages API, you may need to familiarise yourself with:

* **[Authentication](/concepts/guides/authentication)** - The Messages API is authenticated with either [Header-based API Key & Secret Authentication](/concepts/guides/authentication#header-based-api-key-secret-authentication) or [JSON Web Tokens (JWT)](/concepts/guides/authentication#json-web-tokens-jwt).
* **[Workflows](/messages-and-workflows-apis/workflows/overview)** - The Workflow API is used to combine messages together with logic to allow for failover.

## Getting Started

In this Getting Started section we will show you how you can send an SMS. The same steps taken here can be easily modified to send a message across Viber Service Messages, Facebook Messenger and any future channels that we add.

### 1. Configure your Delivery Receipt and Inbound Message endpoint with Nexmo

To receive updates about the state of a message (i.e. "delivered" or "read") you have just sent and to receive inbound messages from your customers you will need to configure an endpoint for Nexmo to send messages to. If you don't have a webhook server set up you can use a service like [hookbin.com](https://hookbin.com/) for free. If the endpoint in your account is already in production and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Set the HTTP Method to POST and enter your endpoint in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

### 2. Generate a JWT to Authenticate with Nexmo

The Messages API authenticates using JSON Web Tokens (JWTs).

In order to create a JWT to authenticate your requests, you will need to create a Nexmo Voice Application. This can be done under the [Voice tab](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI]( https://github.com/Nexmo/nexmo-cli) tool.

You will be asked to provide an Event URL and an Answer URL when creating a Voice Application. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs. Instead the Messages API and Workflows API use the Delivery Receipt and Inbound Message URLs that you set in [Settings](https://dashboard.nexmo.com/settings).

Once you have created a Voice application you can use the application ID and private key to generate a JWT. For more information please visit:

* [Authenticaion with JWTs](https://developer.nexmo.com/concepts/guides/authentication#json-web-tokens-jwt).
* Blog post on [Voice Application management](https://www.nexmo.com/blog/2017/06/29/voice-application-management-easier/).
* [Nexmo libraries](https://developer.nexmo.com/tools).

If you're using the Nexmo CLI the command is:

```curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

This JWT will last 15 minutes. After that, you will need to generate a new one. In production systems, it is advisable to generate a JWT dynamically for each request.

### 3. Send an SMS message with Messages API

Sending an SMS message with the Messages API can be done with one API call, authenticated using the JWT you just created.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` |	The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.
`TO_NUMBER` | The phone number you are sending the message to in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.

| #### Prerequisites
|
| 1. [Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)
|
| 2. [Create an application](/concepts/guides/applications#getting-started-with-applications)
|
| 3. Generate a JWT:
|
|     ```curl
|     $ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
|     $ echo $JWT
|     ```

#### Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-sms'
```

## Building Blocks

* [Send an SMS with Messages API](/messages-and-workflows-apis/messages/building-blocks/send-an-sms-with-messages-api)
* [Send with Facebook Messenger](/messages-and-workflows-apis/messages/building-blocks/send-with-facebook-messenger)
* [Send a Viber Service Message](/messages-and-workflows-apis/messages/building-blocks/send-a-viber-service-message)
* [Send a message with failover](/messages-and-workflows-apis/workflows/building-blocks/send-a-message-with-failover)

## Guides

* [Facebook Messenger](/messages-and-workflows-apis/messages/guides/facebook-messenger)
* [Viber Service Messages](/messages-and-workflows-apis/messages/guides/viber-service-messages)

## Reference

* [Messages API Reference](/api/messages-and-workflows-apis/messages)
* [Workflows API Reference](/api/messages-and-workflows-apis/workflows)

## Notices

### Adding Category and Tag

On the 7th May 2018 Facebook Messenger will make it mandatory to tag the type of message being sent to the user. Viber Service Messages also requires that the type of message is tagged as well. The use of different tags enables the business to send messages for different use cases. For example, with Viber Service Messages, tagging enables the business to send promotional content. With Facebook Messenger tagging enables updates to be sent after the [24+1 window](https://developers.facebook.com/docs/messenger-platform/policy/policy-overview) messaging policy.

To reduce the burden to the developer and a breaking change in the Messages API we will set defaults for each channel. 

For Facebook Messenger, Nexmo sends the `response` type by default.

For Viber Service Messages, Nexmo sends the `transaction` type by default.

The defaults can be overridden by using the channel specific property. For Facebook Messenger the possible values for `category` are `response`, `update` and `message_tag`. If `message_tag` is used, then an additional `tag` for that type needs to be added. A full list of the possible tags is available on [developer.facebook.com](https://developers.facebook.com/docs/messenger-platform/send-messages/message-tags). For Viber Service Message the possible values are `transaction` and `promotion`. The first message to a user on Viber Service Messages must be a `transaction` one.

An example for Facebook Messenger:

```
 ...
   "message":{ 
      "content":{
          "type": "text",
          "text": "Nexmo"
      },
      "messenger": {
         "category": "message_tag",
         "tag": "ticket_update"
      }
   }
...

```

An example for Viber Service Messages:

```
 ...
   "message":{ 
      "content":{
          "type": "text",
          "text": "Nexmo"
      },
      "viber_service_msg": {
         "category": "promotion"
      }
   }
...

```

These defaults will be implemented on the 7th May 2018 at 12:00 GMT. It will also be possible to override the defaults as well after this date.
