---
title: Using Failover
---

The guide below shows how to use the failover functionality of the Workflows API.

## 1. Configure your Delivery Receipt and Inbound Message endpoint with Nexmo

From [Nexmo Dashboard](https://dashboard.nexmo.com), go to [Settings](https://dashboard.nexmo.com/settings).

Set the HTTP method to POST and enter your endpoint in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

For testing, you can use a service like [hookbin.com](https://hookbin.com/) for free to see the data passed to the webhooks. If the endpoint in your account is already in production and you would like a second one for using the Workflows API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

## 2. Generate a JWT to Authenticate with Nexmo

As with the Messages API, the Workflows API authenticates using JWT.

In order to create a JWT for you Nexmo API key you will need to create a Nexmo Voice Application. This can be done under the [Voice tab](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI]( https://github.com/Nexmo/nexmo-cli) tool.

You will be asked to provide an Event URL and an Answer URL when creating a Voice Application. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs. Instead the Messages API and Workflows API use the Delivery Receipt and Inbound Message URLs that you set in [Settings](https://dashboard.nexmo.com/settings).

Once you have created a Voice application you can use the application ID and private key to generate a JWT. There is more information on [Voice Application management]( https://www.nexmo.com/blog/2017/06/29/voice-application-management-easier/) and the use of [Nexmo libraries](https://developer.nexmo.com/tools).

If you're using the Nexmo CLI the command is:

```curl
$ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
$ echo $JWT
```

## 3. Send a message with failover

Sending an message with failover to another channel is done by making one request to the Workflows API endpoint. In this example we will send a Facebook Messenger message that when the failover condition is met (i.e. the message has not been read), the API will proceed to send an SMS.

Key | Description
-- | --
`NEXMO_APPLICATION_ID` |	The ID of the application that you created.
`FROM_NUMBER` | The phone number you are sending the message from in [E.164](https://en.wikipedia.org/wiki/E.164) format. For example `447700900000`.
`SENDER_ID` | Your sender ID. This value should be the `to.id` value you received in the inbound messenger event.
`RECIPIENT_ID` | The recipient ID is the Facebook user you are messaging. This value should be the `from.id` value you received in the inbound messenger event. It is sometimes called the PSID.

| #### Prerequisites
|
| 1. [Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)
|
| 2. [Create an application](/concepts/guides/applications#getting-started-with-applications)
|
| 3. Generate a JWT:
|
|     ```curl
|     $ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
|     $ echo $JWT
|     ```

#### Example

```tabbed_examples
config: 'messages_and_workflows_apis.workflows.send-failover-sms-facebook'
```
