## Create a Nexmo Application

In order to create a JWT to authenticate your API requests, you will need to first create a Nexmo Application.

There are two ways to create a Nexmo Application:

* Using the Dashboard
* Using the Nexmo Command Line Interface

### Create a Nexmo Application using the Dashboard

This can be done under the [Messages and Dispatch tab in the Dashboard](https://https://dashboard.nexmo.com/messages/create-application).

When you are creating the Nexmo Application in the [Nexmo Dashboard](https://dashboard.nexmo.com/messages/create-application) you can click the link _Generate public/private key pair_ - this will create a public/private key pair and the private key will be downloaded by your browser.

### Create a Nexmo Application using the Nexmo CLI

Alternatively, you can create a Nexmo Application using the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) tool if you have [installed it](https://github.com/Nexmo/nexmo-cli).

Using the Nexmo CLI create your application as follows:

``` bash
$ nexmo app:create "My App" https://example.com/webhooks/answer https://example.com/webhooks/event --keyfile=private.key
```

> **TIP:** Make a note of the Nexmo Application ID for the created application, as you will need this to generate your JWT.
