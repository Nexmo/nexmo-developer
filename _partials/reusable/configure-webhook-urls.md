## Configure your webhook URLs

There are at least two webhooks you need to configure:

* Message Status webhook
* Inbound Message webhook

If you want to receive inbound messages you need to configure and handle an Inbound Message Webhook URL. When an inbound message is received this webhook URL is invoked with the message payload.

If you wish to get a status update on a sent message, such as `delivered`, `rejected` or `accepted`, then you need to configure and handle the message status webhook.

> **IMPORTANT:** At the very least your webhook handler should return a 200 response for inbound callbacks.

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

### Callback queue

Please note that callbacks emanating from Nexmo, such as those on your Message Status webhook URL and Inbound Message URL, are queued by Nexmo on a per-account basis, **not** a per-application basis.

To avoid callbacks stalling the callback queue, please ensure that all applications acknowledge callbacks with a 200 response. Further, it is advisable to cease activity on a test application 24 hours before deleting it, or removing webhook configuration, otherwise it could potentially leave callbacks in your callback queue that will not be acknowledged, and therefore result in delays on callbacks destined for your production applications.
