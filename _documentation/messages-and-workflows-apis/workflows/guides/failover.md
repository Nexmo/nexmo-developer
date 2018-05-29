---
title: Using Failover
---

# Using failover

This guide shows you how to use the failover functionality of the Workflows API.

## 1. Configure your Webhook URLs

If you don't have a webhook server set up you can use a service like [Ngrok](https://ngrok.com/) for testing purposes. If you've not used Ngrok before you can find out more in our [Ngrok tutorial](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your Webhook URLs in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

NOTE: You need to explicitly set the HTTP Method to `POST`, as the default is `GET`.

## 2. Create a Nexmo Application

In order to create a JWT to authenticate your requests, you will first need to create a Nexmo Voice Application. This can be done under the [Voice tab in the Dashboard](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

When creating a Nexmo Voice Application, you will be asked to provide an Event URL and an Answer URL. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs.

When you are creating the Nexmo Voice Application you can click the link _Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

For more information on these topics please visit:

* [Nexmo Command Line Interface (CLI)](https://github.com/Nexmo/nexmo-cli).
* [Authentication with JWTs](/concepts/guides/authentication#json-web-tokens-jwt).
* Blog post on [Voice Application management](https://www.nexmo.com/blog/2017/06/29/voice-application-management-easier/).
* [Nexmo libraries](https://developer.nexmo.com/tools).

## 3. Generate a JWT

The Workflows API authenticates using JSON Web Tokens (JWTs). If you are using the client library for Node (or other languages when supported), the creation of JWTs is done for you.

Once you have created a Voice application you can use the Nexmo Application ID and the downloaded private key file to generate a JWT.

If you're using the Nexmo CLI the command is:

``` curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

Remember that JWTs only last fifteen minutes by default.

## 4. Send a message with failover

Sending an message with failover to another channel is achieved by making one request to the Workflows API endpoint. In this example you will implement the following workflow:

1. Send a Facebook Messenger message to the user.
2. If the failover condition is met proceed to the next step. In this example the failover condition is the message not being read.
3. Send an SMS to the user.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.
`SENDER_ID` | Your sender ID. This value should be the `to.id` value you received in the inbound messenger event.
`RECIPIENT_ID` | The recipient ID is the Facebook user you are messaging. This value should be the `from.id` value you received in the inbound messenger event. It is sometimes called the PSID.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.workflows.send-failover-sms-facebook'
```
