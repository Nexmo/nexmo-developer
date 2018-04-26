---
title: Connect an inbound call
navigation_weight: 3
---

# Connect an inbound call

In this building block your Nexmo Application will accept an inbound call and then connect this
call to another user via a new outbound call.

## Prerequisites

- *[Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)*
- *[Create an application](/concepts/guides/applications#getting-started-with-applications)*
- *If you are working on a development machine you will need to make
  sure your server can be accessed by Nexmo over the public
  internet. During the development process you can use a tool such as
  [Ngrok](https://ngrok.com) to do that. How to use Ngrok with nexmo
  is explained in detail in [this blog
  post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).*


## Placeholder values

In the example code snippets you need to substitute the following
variables with suitable values:

Key |	Description
-- | --
`YOUR_SECOND_NUMBER` |	The number you wish the inbound caller to be connected to.

```tabbed_content
source: '_examples/voice/connect-an-inbound-call'
```

```partial
source: _partials/associate-an-application-to-your-webhook.md
```

## Call your Nexmo Number

When you call your Nexmo Number you are connected to the the number
you specified for `YOUR_SECOND_NUMBER`.
