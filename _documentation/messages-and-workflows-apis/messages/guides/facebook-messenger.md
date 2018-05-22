---
title: Facebook Messenger
navigation_weight: 2
---

# Facebook Messenger

You can use the Messages API to send and receive messages using Facebook Messenger.

A Facebook User will normally initiate a communication with a business via the business's Facebook Page.

Facebook Messenger uses its own form of IDs for the Facebook Page and the Facebook User:

* Facebook User - Page-Scoped ID (PSID)
* Facebook Page (business) - Facebook Page ID (FPID)

The Facebook User will have a Page-scoped ID (PSID) and this is unique for each page. The business can only obtain the PSID of a user when the user first sends a message to the business. In Facebook Messenger, the default is for the customer to initiate a conversation with a business.

In order to get started with Facebook Messenger you will need to first link your business's Facebook Page to Nexmo. At this point Nexmo will provide you with your Facebook Page ID (FPID).

You can then test things by sending a message as a Facebook User to your Facebook Page. At this point you will receive an inbound message webhook to your server with the PSID of the Facebook user. You can now use this PSID to send a message back to the user.

The following steps show you how to send a Facebook Messenger message using the Messages API.

## 1. Setup a Facebook Page

To use the Messages API with Facebook Messenger you must have a Facebook Account and a Facebook Page.

* [How do I create a Facebook Account?](https://en-gb.facebook.com/help/570785306433644/?helpref=hc_fnav)
* [How do I create a Facebook Page?](https://en-gb.facebook.com/help/104002523024878?helpref=about_content)

## 2. Generate a JWT

You can generate a JWT with the Nexmo Application you previously created with the following:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.

 ```curl
 $ JWT="$(nexmo jwt:generate /path/to/private.key \application_id=NEXMO_APPLICATION_ID)"
 $ echo $JWT
 ```

Remember that JWTs only last fifteen minutes by default.

## 3. Link your Facebook Page to Nexmo

Next you'll need to link your Facebook Page to Nexmo. This will allow Nexmo to handle the inbound messages and allow you to send messages from the Nexmo Messages API. You will need to paste in the JWT you created in the previous step when prompted. Click the following link when you are ready:

* [Link your Facebook Page to Nexmo](https://static.nexmo.com/messenger/)

## 4. Configure your Webhook URLs

If you have not already done so, you will need to configure the Inbound Message Webhook and Delivery Receipt Webhook URLs.

If you don't have a webhook server set up you can use a service like [hookbin.com](https://hookbin.com/) for testing purposes.

If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your Webhook URLs in the fields labeled **Webhook URL for Inbound Message** and **Webhook URL for Delivery Receipt**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/dashboardSettings.png
```

NOTE: You need to explicitly set the HTTP Method to `POST`, as the default is `GET`.

## 5. Receive a message

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

## 6. Respond to a message

You can use the Messages API to respond to the inbound message. Replace the following variables in the example below:

Key | Description
-- | --
`NEXMO_APPLICATION_ID` | The ID of the application that you created.
`SENDER_ID` | Your sender ID. This value should be the `to.id` value you received in the inbound messenger event.
`RECIPIENT_ID` | The recipient ID is the Facebook user you are messaging. This value should be the `from.id` value you received in the inbound messenger event. It is sometimes called the PSID.

### Example

```tabbed_examples
config: 'messages_and_workflows_apis.messages.send-facebook-messenger'
```
