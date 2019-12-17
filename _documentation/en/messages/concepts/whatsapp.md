---
title: Understanding WhatsApp messaging
navigation_weight: 3
description: WhatsApp messaging solution for businesses.
---

# Understanding WhatsApp messaging

> **IMPORTANT:** Please note WhatsApp will deprecate the "fallback" locale method when sending template messages on January 1st 2020. Please ensure that you are using the "deterministic" option in your requests. 

WhatsApp Business Solution messages can only be sent by businesses that have been approved by WhatsApp. This business profile will also have a green verified label to indicate that it is a legitimate business.

The advantage of WhatsApp is that the identifier of users on the platform is their mobile phone number.

> **NOTE:** WhatsApp is in Limited Availability and Nexmo cannot guarantee you will receive a WhatsApp account.

## Important WhatsApp rules

If your customer initiates messaging with you, you will not be charged for any messages (including MTMs) that you send back to the customer, for up to 24 hours following the last message that your customer sent you. This 24 hour period is known as the Customer Care Window. Any additional message you send to that customer beyond the Customer Care Window must be an MTM, for which you will be charged.

> **IMPORTANT**: The WhatsApp Business Solution may not be used to send any messages to or receive messages from the following countries or regions: Crimea, Cuba, Iran, North Korea, and Syria.

## WhatsApp message types

There are a number of different WhatsApp message types:

Message Type | Description
---|---
Text Message | A plain text message. This is the default message type.
Media Message | A media message. Types are: image, audio, document and video.
Message Template | Message Templates are created in the WhatsApp Manager. Outside of the Customer Care Window messages sent to a customer must be a Message Template type.
Media Message Templates | Media message templates expand the content you can send to recipients beyond the standard message template type to include media, headers, and footers using a `components` object.
Contacts Message | Send a contact list as a message.
Location Message | Send a location as a message.

## How WhatsApp works

A business can start a conversation with a user and a user can start a conversation with a business.

WhatsApp has a core concept of Messages Templates (MTM). These were previously known as Highly Structured Messages (HSM).

> **IMPORTANT:** WhatsApp requires that a message that is sent to a user for the first time, or that is outside the Customer Care Window, is an MTM message. This means the message you first send must contain a suitable template. An example is provided in the following section.

The MTM allows a business to send just the template identifier along with the appropriate parameters instead of the full message content.

> **NOTE:** New templates need to be approved by WhatsApp. Please contact your Nexmo Account Manager to submit the templates. Over time Nexmo will also add generic templates that can be used by all businesses.

MTMs are designed to reduce the likelihood of spam to users on WhatsApp.

For the purpose of testing Nexmo provides a template, `whatsapp:hsm:technology:nexmo:verify`, that you can use:

``` shell
{{1}} code: {{2}}. Valid for {{3}} minutes.
```

The parameters are an array. The first value being `{{1}}` in the MTM.

Below is an example API call:

``` shell
curl -X POST \
  https://api.nexmo.com/beta/messages \
  -H 'Authorization: Bearer' $JWT \
  -H 'Content-Type: application/json' \
  -d '{
   "from":{
      "type":"whatsapp",
      "number":"WHATSAPP_NUMBER"
   },
   "to":{
      "type":"whatsapp",
      "number":"TO_NUMBER"
   },
   "message":{
      "content":{
         "type":"template",
         "template":{
            "name":"whatsapp:hsm:technology:nexmo:verify",
            "parameters":[
               {
                  "default":"Nexmo Verification"
               },
               {
                  "default":"64873"
               },
               {
                  "default":"10"
               }
            ]
         }
      },
      "whatsapp": {
        "policy": "deterministic",
        "locale": "en-GB"
      }
   }
}'
```

## WhatsApp deterministic language policy

> **NOTE:** From January 2020 the *deterministic* language policy will be the default and the *fallback* language policy will be deprecated.

When a message template is sent with the deterministic language policy, the receiving device will query its cache for a *language pack* for the language and locale specified in the message. If not available in the cache, the device will query the server for the required language pack. With the deterministic language policy the target device language and locale settings are ignored. If the language pack specified for the message is not available an error will be logged.

Further information is available in the [WhatsApp documentation](https://developers.facebook.com/docs/whatsapp/message-templates/sending/#language).

## Further information

* [Custom objects](/messages/concepts/custom-objects)

WhatsApp developer documentation:

* [WhatsApp Developer documentation](https://developers.facebook.com/docs/whatsapp)
* [Text Message](https://developers.facebook.com/docs/whatsapp/api/messages/text)
* [Media Message](https://developers.facebook.com/docs/whatsapp/api/messages/media)
* [Message Template](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates)
* [Media Message Template](https://developers.facebook.com/docs/whatsapp/api/messages/message-templates/media-message-templates)
* [Contacts message](https://developers.facebook.com/docs/whatsapp/api/messages/others#contacts-messages)
* [Location message](https://developers.facebook.com/docs/whatsapp/api/messages/others#location-messages)
