---
title: Viber Service Messages
navigation_weight: 3
---

# Viber Service Messages

You can use the Messages API to send outbound Viber Service Messages to Viber Users.

Viber Service Messages can only be sent by businesses that have been approved by Viber. This business profile will also have a green check to indicate that it is a legitimate business.

The advantage of Viber Service Messages is that the identifier of users on the platform is their mobile phone number. The business accounts are limited to only outbound messages to the customer. This means there is no way for a customer to respond and means that you don't need to worry about dealing with inbound messages.

In order to get started with Viber Service Messages you will need to email [sales@nexmo.com](mailto:sales@nexmo.com). Nexmo is an official partner and will handle the application and creation of your Viber Service Messages account for you.

If successful, your account manager will provide you with a Viber Service Messages ID. This ID can only be used on Nexmo.

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

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the Nexmo Application that you created.
`VIBER_SERVICE_MESSAGE_ID` | Your Viber Service Message ID.
`TO_NUMBER` | The phone number you are sending the message to.

> **NOTE:** Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example 447700900000.

## Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-viber'
```
