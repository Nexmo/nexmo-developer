---
title: Create a Messages and Dispatch Application
description: In this step you learn how to create a Messages and Dispatch Application. A Messages and Dispatch application has a message status webhook and inbound message webhook, where the inbound message is of type `whatsapp`, `messenger` or `viber_service_msg`. Inbound SMS has to be handled through your account-level SMS webhook.
---

# Create your Nexmo Messages and Dispatch Application

If you have not yet done so, create a new directory for your project, such as `my-project`. Change into this directory.

Use the CLI to create your Nexmo application:

``` shell
nexmo app:create "My App" https://abcd1234.ngrok.io/inbound https://abcd1234.ngrok.io/status --keyfile=private.key --type=messages
```

Make a note of the generated Application ID. You can also check this in the [Nexmo Dashboard](https://dashboard.nexmo.com/messages/applications).

This command will also create a private key, `private.key` in your current directory.

This command also sets the two webhooks that need to be set: the inbound message and message status webhooks. Nexmo will callback on these webhooks with useful information. All interaction between your App and Nexmo takes place through these webhooks. You must at least acknowledge each of these webhooks in your app with a status 200 response.
