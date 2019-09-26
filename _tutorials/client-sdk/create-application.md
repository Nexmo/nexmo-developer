---
title: Create a Client SDK Application
description: In this step you learn how to create a Client SDK Application.
---

# Create your Nexmo Client SDK Application

Make sure you have changed into your project directory, which is also where you installed the Nexmo Client SDK.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "My Client SDK App" https://abcd1234.ngrok.io/webhooks/answer https://abcd1234.ngrok.io/webhooks/event --keyfile=private.key --type=voice
```

> **NOTE:** You need to change the webhook URLs to suit your local setup. For more information on using Ngrok for local testing please see [our documentation](/concepts/guides/webhooks#using-ngrok-for-local-development).

Make a note of the generated Application ID, as you'll need in in the future. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com).

This command also creates a private key `private.key` in your current directory, which will be used to generate authentication credentials for your application.

This command also sets two webhooks that need to be set: the answer and event webhooks. Nexmo will send a request to the answer webhook when a call is placed or received, and will send useful information to the event webhook over the lifetime of the call.

Any requests that Nexmo makes to these URLs must be acknowledged by returning a HTTP `200` or `204` response.
