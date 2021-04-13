---
title: Create a Voice Application
description: Configure a Vonage Application to receive inbound calls
---

# Create a Voice API application

Use the CLI to create a Voice API application with the webhooks that will be responsible for answering a call on your Vonage number (`/webhooks/answer`) and logging call events (`/webhooks/events`), respectively.

These webhooks need to be accessible by Vonage's servers, so in this tutorial you will use `ngrok` to expose your local development environment to the public Internet. [This blog post](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/) explains how to install and run `ngrok`.

Run `ngrok` using the following command:

```sh
ngrok http 3000
```

Make a note of the temporary host name that `ngrok` provides and use it in place of `example.com` in the following command:

```sh
nexmo app:create "My WebSocket Server" https://example.com/webhooks/answer https://example.com/webhooks/events
```

The command returns an application ID (which you should make a note of) and your public key information (which you can safely ignore for the purposes of this tutorial).