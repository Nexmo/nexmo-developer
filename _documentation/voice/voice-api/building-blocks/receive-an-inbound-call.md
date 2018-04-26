---
title: Receive an Inbound Call
navigation_weight: 1
---

# Receive an inbound call

An inbound call is a call made from any device or application that is
inbound to your Nexmo Application.

In this building block you create a server that implements an Answer
URL webhook that your Nexmo Application will call back on when it
answers the inbound call to the Nexmo Number associated with it.

When the Answer URL webhook is invoked, an NCCO is returned that
controls how the inbound call is processed. In this example the NCCO
results in a text-to-speech message being played.

In this building block you see how to:

1. Implement a server that responds to the Answer URL webhook.
2. Create a Nexmo Application which links to your server's webhook.
3. Link your Nexmo Number with your Nexmo Application.
4. Test an inbound call.

## Placeholder values

In the example code snippets you need to substitute the following
variables with suitable values:

Key | Description
------|-------------
`YOUR_HOSTNAME` | The hostname of your server. For example it may be https://www.example.com
`NEXMO_NUMBER` | The Nexmo Number you purchased to link to this Nexmo Application.
`NEXMO_APPLICATION_ID` | The Nexmo Application Id for the Nexmo Application you create below.


## Prerequisites

- *[Rent a virtual number](/account/guides/numbers#rent-virtual-numbers)*
- *If you are working on a development machine you will need to make
  sure your server can be accessed by Nexmo over the public
  internet. During the development process you can use a tool such as
  [Ngrok](https://ngrok.com) to do that. How to use Ngrok with nexmo
  is explained in detail in [this blog
  post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).*

```tabbed_content
source: '_examples/voice/receive-an-inbound-call'
```

```partial
source: _partials/associate-an-application-to-your-webhook.md
```

## Call your Nexmo Number

Call your Nexmo Number. After a few seconds your call will be answered
and you will hear a text-to-speech message.
