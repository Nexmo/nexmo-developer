---
title: Create a Voice Application
description: In this step you learn how to create a Voice Application. A Voice application has an answer webhook and an events webhook.
meta_title: Create a Voice application for the Vonage APIs
meta_description: A Voice application has an answer webhook and an events webhook.
---

There are two methods for creating a Voice application:

1. Using the Nexmo CLI
2. Using the Dashboard

Each of these methods is described in the following sections.

### How to create a Voice application using the Nexmo CLI

To create your application using the Nexmo CLI, enter the following command into the shell replacing `NGROK_HOST_NAME` with the ngrok host that you got when you set up ngrok:

``` shell
nexmo app:create "AspNetTestApp" http://NGROK_HOST_NAME/webhooks/answer http://NGROK_HOST_NAME/webhooks/events
```

This command creates a Vonage Application with Voice [capability](/application/overview#capabilities). It  configures the Application with your answer and event webhook URLs and generates a private key file `private.key`, which you should save in your project directory.

The command returns a unique Application ID. Use this Application ID to link your Vonage virtual number to your Application by executing the following:

```shell
nexmo link:app VONAGE_NUMBER APPLICATION_ID
```

This will link that Vonage Virtual Number to your application, which will cause all voice events occurring for that number to be routed to your designated URLs.

### How to create a Voice application using the Dashboard

You can create Voice applications in the [Dashboard](https://dashboard.nexmo.com/applications).

To create your application using the Dashboard:

1. Under [Applications](https://dashboard.nexmo.com/applications) in the Dashboard, click the **Create a new application** button.

2. Under **Name**, enter the Application name. Choose a name for ease of future reference.

3. Click the button **Generate public and private key**. This will create a public/private key pair and the private key will be downloaded by your browser. Save the private key that was generated.

4. Under **Capabilities** select the **Voice** button.

5. In the **Answer URL** box, enter the URL for your inbound calls webhook, for example, `http://example.com/webhooks/answer`.

6. In the **Event URL** box, enter the URL for your call status webhook, for example, `http://example.com/webhooks/events`.

7. Click the **Generate new application** button.

8. You are now taken to the next step of the Create Application procedure where you should link your Vonage number to the application.

You have now created your application.

> **NOTE:** Before testing your application ensure that your webhooks are configured and your webhook server is running.
