---
title: Create a Client SDK Application
description: In this step you learn how to create a Client SDK Application.
---

# Create your Nexmo Client SDK Application

Make sure you have changed into your project directory, which is also where you installed the Nexmo Client SDK.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "My Client SDK App" https://abcd1234.ngrok.io/webhooks/answer https://abcd1234.ngrok.io/webhooks/event --keyfile=private.key --type=rtc
```

> **NOTE:** You need to change the webhook URLs to suit your local setup. For more information on using Ngrok for local testing please see [our documentation](/concepts/guides/webhooks#using-ngrok-for-local-development).

Make a note of the generated Application ID. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com).

This command also creates a private key `private.key` in your current directory.

This command also sets the two webhooks that need to be set: the answer and event webhooks. Nexmo will callback on these webhooks with useful information. All interaction between your App and Nexmo takes place through these webhooks. You must at least acknowledge each of these webhooks in your app with a status 200 response.