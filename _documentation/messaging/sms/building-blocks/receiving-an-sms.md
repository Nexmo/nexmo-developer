---
title: Receiving an SMS
navigation_weight: 3
---

# Receiving an SMS

Handling inbound SMS with Nexmo is easy. You just need to create a webhook endpoint and configure your number or account to point to the endpoint.

## Prerequisites

- *[Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)*

```tabbed_content
source: '_examples/messaging/sms/receiving-an-sms'
```

You'll need to expose your server to the open internet. During development you can use a tool like [Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) to do that.

## Configure your SMS endpoint with Nexmo

From [Nexmo Dashboard](https://dashboard.nexmo.com) go to [Settings](https://dashboard.nexmo.com/settings).

Enter your endpoint in the field labeled **Webhook URL for Inbound Message**:

```screenshot
script: app/screenshots/webhook-url-for-inbound-message.js
image: public/assets/screenshots/1b9047ceebd9312df0a3be8202be342c4da70201.png
```

## Send your Nexmo number an SMS

Now when you send your Nexmo number an SMS you should see it logged in your console.
