---
title: Using Failover
---

# Using failover

This guide shows you how to use the failover functionality of the Workflows API.

The example Workflow given here will attempt to send a Facebook message using the Messages API, and if this fails it then attempts to send an SMS message to the user using the Messages API.

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

## 4. Send a message with failover

Sending an message with failover to another channel is achieved by making a single request to the Workflows API endpoint.

In this example you will implement the following workflow:

1. Send a Facebook Messenger message to the user using the Messages API.
2. If the failover condition is met proceed to the next step. In this example the failover condition is the message not being read.
3. Send an SMS to the user using the Messages API.

Key | Description
-- | --
`FROM_NUMBER` | The phone number you are sending the message from. **Don't use a leading `+` or `00` when entering a phone number, start with the country code, for example, 447700900000.**
`SENDER_ID` | Your Page ID. The `SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`RECIPIENT_ID` | The PSID of the user you want to reply to. The `RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.workflows.send-failover-sms-facebook'
```
