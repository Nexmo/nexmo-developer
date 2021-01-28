---
title: Configure your Voice application
description: Tell Vonage where your webhooks are
---

# Configure your Voice Application

Now that you have defined your webhooks, you need to tell the Vonage API platform where to find them. You do that by configuring them in the Voice Application you created as part of the [prerequisites](voice/voice-api/tutorials/ivr/prerequisites/) for this tutorial.

You need to configure the Voice Application with the following information:

* `APPLICATION_ID` - the UUID of your application
* `APPLICATION_NAME` - a name for your application
* `answer_url` - the URL where your webhook delivers the Nexmo Call Control Object that controls the flow of incoming calls.
* `event_url` - the URL the platform sends event information asynchronously to when the call status changes

The `answer_url` and `event_url` consist of your Ngrok domain name (as generated in the [prerequisites](/voice/voice-api/tutorials/ivr/prerequisites/) for this tutorial) followed by the route for each webhook in your code.

> Ensure that [Ngrok](/tools/ngrok) is running before you perform this step.

Execute the following CLI command to update your application with the following data:

```
nexmo app:update APPLICATION_ID "APPLICATION_NAME" https://mydomain.ngrok.io/webhooks/answer https://mydomain.ngrok.io/webhooks/event
```

For example:

```
nexmo app:update 228c1ad1-176d-406c-a63a-b97e6fd3fd52 https://63daf1c05d6f.ngrok.io/webhooks/answer https://63daf1c05d6f.ngrok.io/webhooks/events
```
