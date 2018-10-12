## Configure your webhook URLs

There are at least two webhooks you may need to configure:

* Message Status webhook
* Inbound Message webhook

If you want to receive inbound messages you will need to configure an Inbound Message Webhook URL. When an inbound message is received this webhook URL will be invoked with the message payload.

If you wish to get a status update on a sent message, such as `delivered`, `rejected` or `accepted`, then you will need to configure the message status webhook.

### To configure the webhook URLs

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Messages and Dispatch](https://dashboard.nexmo.com/messages/create-application).

> **TIP:** If the Webhook URLs for messages in your Nexmo Account are already in production use and you would like a second one for using the Messages API, please email [support@nexmo.com](mailto:support@nexmo.com) and ask for a sub API Key.

Enter your Webhook URLs in the fields labeled **Status URL** and **Inbound URL**.

The values you enter for webhook URLs depends on where your webhook server is located. If your server was running on port 3000 on `example.com` your webhook URLs might be:

Webhook | URL
---|---
Status URL | https://www.example.com:3000/webhooks/message-status
Inbound URL | http://www.example.com:3000/webhooks/inbound-message

> **NOTE:** The default method of `POST` should be used for both of the webhook URLs.

### Testing locally via Ngrok

If you want to test your application locally you can use Ngrok.

See our information on [Using Ngrok for local development](/concepts/guides/webhooks#using-ngrok-for-local-development)

If using Ngrok in this manner you would use the Ngrok URLs for your webhook URLs:

* `https://abcdef1.ngrok.io:3000/webhooks/inbound-message`
* `https://abcdef1.ngrok.io:3000/webhooks/message-status`
