---
title: Overview
---

# Messages Overview

The Messages API is a single API that enables integration with various communication channels such as: SMS, Facebook Messenger and Viber.

## Developer Preview

This API is currently in Developer Preview and you will need to [request access](https://www.nexmo.com/products/messages) to use it.

During Developer Preview Nexmo will expand the capabilities of the API. Please visit the API Reference for a comprehensive breakdown. Currently the following features are supported:

* Outbound text messages on SMS, Viber Service Messages and Facebook Messenger.
* Outbound media messages on Facebook Messenger.
* Inbound text, media and location messages on Facebook Messenger.

There may be issues so Nexmo welcomes your feedback. Any suggestions you make help us improve the product. If you do need help, please email [support@nexmo.com](mailto:support@nexmo.com) and include Messages API in the subject line. Please note that during the Developer Preview period support times are limited to Monday to Friday.

If you are using the Node library then during the Developer Preview period the library can be installed with the command:

```
$ npm install nexmo@beta
```

## Contents

* [Concepts](#concepts)
* [Quickstart](#quickstart)
* [Guides](#guides)
* [Building Blocks](#building-blocks)
* [Reference](#reference)
* [Notices](#notices)

## Concepts

To use the Messages API, you may need to familiarise yourself with:

* **[Authentication](/concepts/guides/authentication)** - The Messages API is authenticated with either [Header-based API Key and Secret Authentication](/concepts/guides/authentication#header-based-api-key-secret-authentication) or [JSON Web Tokens (JWT)](/concepts/guides/authentication#json-web-tokens-jwt).
* **[Workflows](/messages-and-workflows-apis/workflows/overview)** - The Workflow API is used to combine messages together with logic to allow for failover.

## Quickstart

The following code shows how to send an SMS message:

```
curl -X POST https://api.nexmo.com/beta/messages \
  -H 'Authorization: Basic base64(API_KEY:API_SECRET)'\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "from": { "type": "sms", "number": "FROM_NUMBER" },
    "to": { "type": "sms", "number": "TO_NUMBER" },
    "message": {
      "content": {
        "type": "text",
        "text": "This is an SMS sent from the Messages API"
      }
    }
  }'
```

In the above example you will need to:

1. Replace `FROM_NUMBER` and `TO_NUMBER` in the code above with suitable phone numbers in E.164 format, for example, 447700900000.
2. Replace `base64(API_KEY:API_SECRET)` with the correct Base64 encoded string. Further information on how to do this can be found in the [Header-based API Key and Secret Authentication documentation](/concepts/guides/authentication#header-based-api-key-secret-authentication).

The example code will return the message ID and an SMS will be sent to the number specified.

## Guides

* [SMS Messages](/messages-and-workflows-apis/messages/guides/sms-messages)
* [Facebook Messenger](/messages-and-workflows-apis/messages/guides/facebook-messenger)
* [Viber Service Messages](/messages-and-workflows-apis/messages/guides/viber-service-messages)

## Building Blocks

* [Send an SMS with the Messages API](/messages-and-workflows-apis/messages/building-blocks/send-an-sms-with-messages-api)
* [Send a message with Facebook Messenger](/messages-and-workflows-apis/messages/building-blocks/send-with-facebook-messenger)
* [Send a message with Viber Service Message](/messages-and-workflows-apis/messages/building-blocks/send-a-viber-service-message)
* [Send a message with a failover Workflow](/messages-and-workflows-apis/workflows/building-blocks/send-a-message-with-failover)

## Reference

* [Messages API Reference](/api/messages-and-workflows-apis/messages)
* [Workflows API Reference](/api/messages-and-workflows-apis/workflows)

## Notices

### Adding Category and Tag

On the 7th May 2018 Facebook Messenger will make it mandatory to tag the type of message being sent to the user. Viber Service Messages also requires that the type of message is tagged as well. The use of different tags enables the business to send messages for different use cases. For example, with Viber Service Messages, tagging enables the business to send promotional content. With Facebook Messenger tagging enables updates to be sent after the [24+1 window](https://developers.facebook.com/docs/messenger-platform/policy/policy-overview) messaging policy.

To reduce the burden to the developer and a breaking change in the Messages API Nexmo sets defaults for each channel:

* For Facebook Messenger, Nexmo sends the `response` type by default.
* For Viber Service Messages, Nexmo sends the `transaction` type by default.

The defaults can be overridden by using the channel specific property. For Facebook Messenger the possible values for `category` are `response`, `update` and `message_tag`. If `message_tag` is used, then an additional `tag` for that type needs to be added. A full list of the possible tags is available on [developer.facebook.com](https://developers.facebook.com/docs/messenger-platform/send-messages/message-tags). For Viber Service Messages the possible values are `transaction` and `promotion`. The first message to a user on Viber Service Messages must be a `transaction` one.

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

These defaults were implemented on the 7th May 2018 at 12:00 GMT. It is also possible to override the defaults after this date.
