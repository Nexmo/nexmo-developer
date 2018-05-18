---
title: SMS Messages
navigation_weight: 1
---

# SMS Messages

In this guide you will see how to send an SMS. The same steps taken here can be easily modified to send a message across Viber Service Messages, Facebook Messenger and future channels that Nexmo might add.

## 1. Configure your Webhook URLs

If you intend to receive inbound messages you will need to configure an inbound message webhook URL. To receive updates about the status of a message, such as "delivered" or "read", you need to configure a delivery receipt webhook URL.

If you don't have a webhook server set up you can use a service like [hookbin.com](https://hookbin.com/) for testing purposes.

If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your Webhook URLs in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

NOTE: You need to explicitly set the HTTP Method to `POST`, as the default is `GET`.

## 2. Create a Nexmo Application

The Messages API authenticates using JSON Web Tokens (JWTs). If you are using the client library for Node (or other languages when supported), the creation of JWTs is done for you.

In order to create a JWT to authenticate your requests, you will need to create a Nexmo Voice Application. This can be done under the [Voice tab in the Dashboard](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

When creating a Nexmo Voice Application, you will be asked to provide an Event URL and an Answer URL. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs.

When you are creating the Nexmo Voice Application you can click the link _Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

For more information on these topics please visit:

* [Nexmo Command Line Interface (CLI)](https://github.com/Nexmo/nexmo-cli).
* [Authentication with JWTs](/concepts/guides/authentication#json-web-tokens-jwt).
* Blog post on [Voice Application management](https://www.nexmo.com/blog/2017/06/29/voice-application-management-easier/).
* [Nexmo libraries](https://developer.nexmo.com/tools).

## 3. Generate a JWT

Once you have created a Voice application you can use the Nexmo Application ID and the downloaded private key file to generate a JWT.

If you're using the Nexmo CLI the command is:

``` curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

This JWT will last fifteen minutes. After that, you will need to generate a new one. In production systems, it is advisable to generate a JWT dynamically for each request.

## 4. Send an SMS message with Messages API

Sending an SMS message with the Messages API can be done with one API call, authenticated using the JWT you just created. If you are using the library the JWT is created for you.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.
`TO_NUMBER` | The phone number you are sending the message to in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-sms'
```
