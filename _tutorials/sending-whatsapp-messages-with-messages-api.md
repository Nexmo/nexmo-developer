---
title: Sending WhatsApp messages with Messages API
products: messages-and-workflows-apis/messages
description: The Messages API provides a unified facility for sending messages over multiple channel types. This tutorial looks at sending messages via the WhatsApp channel using the Messages API.
languages:
    - Curl
    - Node
---

# Sending WhatsApp messages with Messages API

You can use the Messages API to exchange messages with WhatsApp users.

WhatsApp Business Solution can only be sent by businesses that have been approved by WhatsApp. This business profile will also have a green verfied label to indicate that it is a legitimate business.

The advantage of WhatsApp is that the identifier of users on the platform is their mobile phone number.

In order to get started with WhatsApp you will need to email [sales@nexmo.com](mailto:sales@nexmo.com). Nexmo is an official partner and will handle the application and creation of your WhatsApp Business account for you. Currently WhatsApp is in Limited Availability and only a certain number of customers will be onboarded.

If successful, your account manager will provide you with a WhatsApp number.

## How WhatsApp works

A business can start a conversation with a user and a user can start a conversation with a business.

WhatsApp has a core concept of Messages Templates (MTM). These were previously known as Highly Structured Messages (HSM).

WhatsApp requires that a message sent to a user for the first time, or is outside the Customer Care Window, is an MTM message.

The MTM allows a business to send just the template identifier along with the appropriate parameters instead of the full message content.

New templates need to be approved by WhatsApp. Please contact your Nexmo Account Manager to submit the templates. Over time Nexmo will also add generic templates that can be used by all businesses.

MTMs are designed to reduce the likelihood of spam to users on WhatsApp.

For the purpose of testing Nexmo provides a template, `whatsapp:hsm:technology:nexmo:verify`, that you can use:

```
{{1}} code: {{2}}. Valid for {{3}} minutes.
```

The parameters are an array. The first value being `{{1}}` in the MTM.

Below is the example API call:

```
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
      }
   }
}
'
```

## Important WhatsApp Rules

If your customer initiates messaging with you, WhatsApp will not charge you for any messages (including MTMs) that you send back to the customer, for up to 24 hours following the last message that your customer sent you. This 24 hour period is known as the Customer Care Window. Any additional message you send to that customer beyond the Customer Care Window must be an MTM, for which WhatsApp will charge you.

> **IMPORTANT**: The WhatsApp Business Solution may not be used to send any messages to or receive messages from the following countries: Crimea, Cuba, Iran, North Korea, and Syria.

```partial
source: _partials/olympus/prereqs.md
```

## The steps

After the prerequisites have been met, the steps are as follows:

1. [Contact Nexmo](mailto:sales@nexmo.com) - You will need to obtain a WhatsApp number.
2. [Configure your webhook URLs](#configure-your-webhook-urls) - This step only required for support of inbound message support and delivery receipts.
3. [Create a Nexmo Application](#create-a-nexmo-application) - The resultant Application ID is used to generate a JWT that you need to make API calls. If you already have an Application ID you can use you don't need to do this step.
4. [Generate a JWT](#generate-a-jwt) - This step is only required if you are not using the client library.
5. [Send a WhatsApp message](#send-a-whatsapp-message) - This step uses the Nexmo Messages API to send a WhatsApp message.

```partial
source: _partials/olympus/configure-webhook-urls.md
```

```partial
source: _partials/olympus/create-a-nexmo-application.md
```

```partial
source: _partials/olympus/generate-a-jwt.md
```

## Send a WhatsApp message

Please note that free form text messages can only be sent when a customer sends a message to the business first. The business has up to 24 hours from the last moment the customer messages to send a free form message back. After that period a MTM needs to be used.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`WHATSAPP_NUMBER` | Your WhatsApp number.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```building_blocks
source: '_examples/olympus/send-whatsapp-message'
```

## Further reading

* [Messages documentation](/messages-and-workflows-apis/messages/overview)
