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

Make a note of the generated Application ID, as you'll need it in the future. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com/voice/your-applications).

![Nexmo Developer Dashboard Applications screenshot](/assets/screenshots/tutorials/app-to-phone/nexmo-dashboard-applications.png "Nexmo Developer Dashboard Applications screenshot")

This command also creates a private key `private.key` in your current directory, which will be used to generate authentication credentials for your application.

This command also configures the answer and event webhook endpoints. Nexmo makes a request to the answer webhook when a call is placed or received, and sends useful information to the event webhook over the lifetime of the call.

Any requests that Nexmo makes to these URLs must be acknowledged by returning a HTTP `200` or `204` response.
