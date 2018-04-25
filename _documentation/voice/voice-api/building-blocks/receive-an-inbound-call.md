---
title: Receive an Inbound Call
navigation_weight: 1
---

# Receive an Inbound Call

Receiving inbound calls with Nexmo is easy. You just need a server that provides a endpoint that Nexmo will call when your number is called. You configure this endpoint by associating your Nexmo number with an application.

## Prerequisites

- *[Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)*

```tabbed_content
source: '_examples/voice/receive-an-inbound-call'
```

You'll need to expose your server to the open internet. During development you can use a tool like [Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) to do that.

```partial
source: _partials/associate-an-application-to-your-webhook.md
```

## Call your number

When you call your Nexmo number you should now get a TTS response back.
