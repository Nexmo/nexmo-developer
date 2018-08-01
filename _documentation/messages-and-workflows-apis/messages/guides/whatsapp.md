---
title: WhatsApp
navigation_weight: 4
---

# WhatsApp

You can use the Messages API to exchange messages with WhatsApp users.

WhatsApp Business Solution can only be sent by businesses that have been approved by WhatsApp. This business profile will also have a green verfied label to indicate that it is a legitimate business.

The advantage of WhatsApp is that the identifier of users on the platform is their mobile phone number.

In order to get started with WhatsApp you will need to email [sales@nexmo.com](mailto:sales@nexmo.com). Nexmo is an official partner and will handle the application and creation of your WhatsApp Business account for you. Currently WhatsApp is in Limited Availability and only a certain number of customers will be onboarded.

If successful, your account manager will provide you with a WhatsApp number.

## How WhatsApp works

A business can start a conversation with a user and a user can start a conversation with a business.

A core concept with WhatsApp are Messages Templates (MTM), formally known as Highly Structured Messages (HSM). WhatsApp requires that a message sent to a user for the first time, or is outside the Customer Care Window, is a MTM message.

The MTM allows a business to send just the template identifier along with the appropriate parameters instead of the full message content.

New templates need to be approved by WhatsApp. Please contact your Nexmo Account Manager to submit the templates. Over time Nexmo will also add generic templates that can be used by all businesses.

MTMs are designed to reduce the likelihood of spam to users on WhatsApp.

For the purpose of testing Nexmo provides a template, `whatsapp:hsm:technology:nexmo:verify`, that you can use:

`{{1}} code: {{2}}. Valid for {{3}} minutes.`

The parameters are an array. The first value being `{{1}}` in the HSM.

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

Additional WhatsApp Rules:

- If your customer initiates messaging with you, WhatsApp will not charge you for any messages (including MTMs) that you send back to the customer, for up to 24 hours following the last message that your customer sent you. This 24 hour period is known as the Customer Care Window. Any additional message you send to that customer beyond the Customer Care Window must be an MTM, for which WhatsApp will charge you.
- **Exclusions**: The WhatsApp Business Solution may not be used to send any messages to or from the following countries and regions: Crimea, Cuba, Iran, North Korea, and Syria.

## 1. Configure your Webhook URLs

If you intend to receive inbound messages you will need to configure an Inbound Message Webhook URL.

To receive updates about the status of a message, such as "delivered" or "read", you need to configure a Delivery Receipt Webhook URL.

If you don't have a webhook server set up, you can use a service like [Ngrok](https://ngrok.com/) for testing purposes. If you've not used Ngrok before you can find out more in our [Ngrok tutorial](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

**TIP:** If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your Webhook URLs in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

**NOTE:** You need to explicitly set the HTTP Method to `POST`, as the default is `GET`.

## 2. Create a Nexmo application

In order to create a JWT to authenticate your API requests, you will need to first create a Nexmo Voice Application. This can be done under the [Voice tab in the Dashboard](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

When creating a Nexmo Voice Application, you will be asked to provide an Event URL and an Answer URL. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs, so in this case you can just set them to the suggested values of `http://example.com/event` and `http://example.com/answer` respectively.

When you are creating the Nexmo Voice Application in the [Nexmo Dashboard](https://dashboard.nexmo.com) you can click the link _Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

Make a note of the Nexmo Application ID for the created application.

## 3. Generate a JWT

Once you have created a Voice application you can use the Nexmo Application ID and the downloaded private key file, `private.key`, to generate a JWT.

**TIP:** If you are using the client library for Node (or other languages when supported), the dynamic creation of JWTs is done for you.

If you're using the Nexmo CLI the command to create the JWT is:

``` curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

This JWT will be valid for fifteen minutes. After that, you will need to generate a new one.

**TIP:** In production systems, it is advisable to generate a JWT dynamically for each request.

## 4. Send a message

Please note that free form text messages can only be sent when a customer sends a message to the business first. The business has up to 24 hours from the last moment the customer messages to send a free form message back. After that period a MTM needs to be used.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`WHATSAPP_NUMBER` | Your WhatsApp number.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-whatsapp'
```
