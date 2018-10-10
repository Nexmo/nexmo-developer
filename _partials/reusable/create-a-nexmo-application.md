## Create a Nexmo Application

In order to create a JWT to authenticate your API requests, you will need to first create a Nexmo Application.

### Create a Nexmo Application using the Dashboard

Depending on the product you are willing to use, there are two application types which can be created: Voice and Messages.

Messages applications are also used by Dispatch API.

[Create Voice application](https://dashboard.nexmo.com/voice/create-application)

[Create Messages application](https://dashboard.nexmo.com/messages/create-application)

Applications provide fine-grained control over system notifications and inbound flows.

When you are creating Nexmo Application in the [Nexmo Dashboard](https://dashboard.nexmo.com) you can click the link Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

### Create Voice Nexmo Application using the Nexmo CLI

Alternatively, for Voice applications, you can create a Nexmo Application using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

Using the Nexmo CLI create your application as follows:

``` bash
$ nexmo app:create "My App" https://example.com/webhooks/answer https://example.com/webhooks/event --keyfile=private.key
```

> **TIP:** Make a note of the Nexmo Application ID for the created application, as you will need this to generate your JWT.
