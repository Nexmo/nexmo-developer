---
title: Understanding WhatsApp messaging
navigation_weight: 3
description: WhatsApp messaging solution for businesses.
---

# Understanding WhatsApp messaging

WhatsApp Business Solution messages can only be sent by businesses that have been approved by WhatsApp. This business profile will also have a green verified label to indicate that it is a legitimate business.

The advantage of WhatsApp is that the identifier of users on the platform is their mobile phone number.

> Apply for a WhatsApp Business number before the end of the year and Nexmo will waive the setup and monthly hosting fees through March 31st 2020.

**NOTE:** Setup fees and monthly service waived through March 31, 2020 for WhatsApp Business Accounts created from Oct 1, 2019 through Dec 31, 2019. Taxes and usage fees not included. Limited promotion quantity available. One (1) message per second throughput for entry tier. Other restrictions may apply.

[Get Started](https://bit.ly/Vonage-WhatsApp-Form)

> **NOTE:** WhatsApp is in Limited Availability and Nexmo cannot guarantee you will receive a WhatsApp account.

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
      },
      "whatsapp": {
        "policy": "deterministic",
        "locale": "en-GB"
      }
   }
}
'
```

## Important WhatsApp Rules

If your customer initiates messaging with you, you will not be charged for any messages (including MTMs) that you send back to the customer, for up to 24 hours following the last message that your customer sent you. This 24 hour period is known as the Customer Care Window. Any additional message you send to that customer beyond the Customer Care Window must be an MTM, for which you will be charged.

> **IMPORTANT**: The WhatsApp Business Solution may not be used to send any messages to or receive messages from the following countries or regions: Crimea, Cuba, Iran, North Korea, and Syria.
