---
title: Facebook Messenger
navigation_weight: 2
---

# Facebook Messenger

You can use the Messages API to send and receive messages using Facebook Messenger.

Only an individual may have a Facebook Profile, whereas a business must have a Facebook Page.

A Facebook user must initiate communication using Facebook Messenger via the business's Facebook Page. A message from the business to the Facebook user will otherwise be refused.

Facebook Messenger uses its own form of IDs for the Facebook User and the Facebook Page :

* Facebook User (profile) - Page-Scoped ID (PSID)
* Facebook Page (business) - Page ID

The Facebook User will have a Page-scoped ID (PSID) and this is unique for each Facebook Profile. The business can only obtain the PSID of a user when the user sends a message to the business. In Facebook Messenger, the default is for the customer to initiate a conversation with a business.

In order to get started with Facebook Messenger you will need to link your business's Facebook Page to Nexmo. At this point Nexmo will provide you with your Facebook Page ID.

You can then test things by sending a message as a Facebook User to your own Facebook Page. At this point you will receive an inbound message webhook to your server with the PSID of the Facebook user. You can now use this PSID to send a message back to the user.

The following steps show you how to send a Facebook Messenger message using the Messages API.

## 1. Setup a Facebook Page

To use the Messages API with Facebook Messenger you must have a Facebook Account and a Facebook Page.

* [How do I create a Facebook Account?](https://en-gb.facebook.com/help/570785306433644/?helpref=hc_fnav)
* [How do I create a Facebook Page?](https://en-gb.facebook.com/help/104002523024878?helpref=about_content)

## 2. Create a Nexmo Application

In order to create a JWT to authenticate your API requests, you will need to first create a Nexmo Voice Application. This can be done under the [Voice tab in the Dashboard](https://dashboard.nexmo.com/voice/create-application) or using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

When creating a Nexmo Voice Application, you will be asked to provide an Event URL and an Answer URL. These are currently only used by the Voice API and are ignored by the Messages and Workflows APIs, so in this case you can just set them to the suggested values of `http://example.com/event` and `http://example.com/answer` respectively.

When you are creating the Nexmo Voice Application in the [Nexmo Dashboard](https://dashboard.nexmo.com) you can click the link _Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

Make a note of the Nexmo Application ID for the created application.

## 3. Generate a JWT

Once you have created a Voice application you can use the Nexmo Application ID and the downloaded private key file, `private.key`, to generate a JWT.

**TIP:** If you are using the client library for Node (or other languages when supported), the dynamic creation of JWTs is done for you.

You can generate a JWT with the Nexmo Application you previously created with the following:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.

 ```curl
 $ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
 $ echo $JWT
 ```

Remember that by default JWTs only last fifteen minutes.

**TIP:** In production systems, it is advisable to generate a JWT dynamically for each request.

## 4. Link your Facebook Page to Nexmo

Next you'll need to link your Facebook Page to Nexmo. This will allow Nexmo to handle the inbound messages and allow you to send messages from the Nexmo Messages API. This process needs to be authenticated by JWT. You will need to paste in the JWT you created in the previous step when prompted.

Click the following link when you have your JWT pasted to the clipboard and you are ready to link your Facebook Page to Nexmo:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

## 5. Configure your Webhook URLs

If you have not already done so, you will need to configure the Inbound Message Webhook and Delivery Receipt Webhook URLs.

If you don't have a webhook server set up you can use a service like [Ngrok](https://ngrok.com/) for testing purposes. If you've not used Ngrok before you can find out more in our [Ngrok tutorial](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).

If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your Webhook URLs in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

**NOTE:** You need to explicitly set the HTTP Method to `POST`, as the default is `GET`.

## 6. Receive a message

When a message is sent to your Facebook Page an event will be sent to your Inbound Message Webhook URL. An example event is shown here:

```json
{
  "message_uuid":"aaaaaaaa-bbbb-cccc-dddd-0123456789ab",
  "to":{
    "type":"messenger",
    "id":"0000000000000000"
  },
  "from":{
    "type":"messenger",
    "id":"1111111111111111"
  },
  "timestamp":"2020-01-01T14:00:00.000Z",
  "message":{
    "content":{
      "type":"text",
      "text":"Hello from Facebook Messenger!"
    }
  }
}
```

## 7. Reply to a message

You can use the Messages API to respond to the inbound message received from the Facebook User. 

Replace the following variables in the example below with actual values:

Key | Description
-- | --
`SENDER_ID` | Your Page ID. The `SENDER_ID` is the same as the `to.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.
`RECIPIENT_ID` | The PSID of the user you want to reply to. The `RECIPIENT_ID` is the PSID of the Facebook User you are messaging. This value is the `from.id` value you received in the inbound messenger event on your Inbound Message Webhook URL.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-facebook-messenger'
```
