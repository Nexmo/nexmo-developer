---
title: SMS Messages
navigation_weight: 1
---

# SMS Messages

In this guide you will see how to send an SMS. The same steps taken here can be easily modified to send a message across Viber Service Messages, Facebook Messenger and future channels that Nexmo might add.

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

## 2. Create a Nexmo Application

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

## 4. Send an SMS message with the Messages API

Sending an SMS message with the Messages API can be done with one API call, authenticated using the JWT you just created.

In the example code below you will need to replace the following variables with actual values:

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-sms'
```
