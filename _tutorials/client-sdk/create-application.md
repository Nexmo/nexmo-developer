---
title: Create a Client SDK Application
description: In this step you see how to create a Client SDK Application.
---

# Create your Nexmo Client SDK Application

If you have not yet done so, create a new directory for your project, such as `my-project`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "My Client SDK App" https://abcd1234.ngrok.io/answer https://abcd1234.ngrok.io/event --keyfile=private.key --type=rtc
```

Make a note of the generated Application ID. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com).

This command also creates a private key `private.key` in your current directory.

This command also sets the two webhooks that need to be set: the answer and event webhooks. Nexmo will callback on these webhooks with useful information. All interaction between your App and Nexmo takes place through these webhooks. You must at least acknowledge each of these webhooks in your app with a status 200 response.
