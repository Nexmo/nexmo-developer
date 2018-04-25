---
title: Connect an inbound call
---

# Connect an inbound call

Connecting two calls with Nexmo is easy. In this example we'll accept an inbound call and make an outbound call that will be connected.

Replace the following variables in the example below.

Key |	Description
-- | --
`YOUR_SECOND_NUMBER` |	The number you wish the inbound caller to be connected to.

```tabbed_content
source: '_examples/voice/connect-an-inbound-call'
```

You'll need to expose your server to the open internet. During development you can use a tool like [Ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) to do that.


## Associate an application to your webhook

To link your number to the endpoint you've just created we'll need an Application.

```
$ nexmo app:create demo <YOUR_HOSTNAME>/webhooks/answer <YOUR_HOSTNAME>/webhooks/event
$ nexmo link:app <NEXMO_NUMBER> <NEXMO_APPLICATION_ID>
```

## Call your number

When you call your Nexmo number you should be connected to the the number you specified in place of `YOUR_SECOND_NUMBER`
