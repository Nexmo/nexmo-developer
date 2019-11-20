---
title: Test a Messages webhook server
description: Expose your local webhook server to the internet
---

If you want to test your application locally you can use Ngrok.

See our information on [Using Ngrok for local development](/concepts/guides/webhooks#using-ngrok-for-local-development)

If using Ngrok in this manner you would use the Ngrok URLs for your webhook URLs:

* `https://abcdef1.ngrok.io:3000/webhooks/inbound-message`
* `https://abcdef1.ngrok.io:3000/webhooks/message-status`