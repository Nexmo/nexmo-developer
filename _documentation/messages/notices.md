---
title: Notices
---

# Notices

## Adding Category and Tag

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
