---
title: Webhooks
description: How to set and use webhook endpoints for the Nexmo APIs.
navigation_weight: 5
---

# Webhooks

Webhooks are an extension of an API, but instead of your code requesting data from Nexmo, Nexmo sends data to you. The data arrives in a web request to your application. A webhook may be the result of an earlier API call (this type of webhook is also called a "callback"), such as an asynchronous request to the Number Insight API. Webhooks are also used to notify your application of events such as an incoming call or message.

Since the Nexmo servers need to be able to send data to your application via webhooks, you need to set up a webserver to receive the incoming HTTP requests. You also need to specify the URL of each webhook on your webserver so that data can be sent to each one.

## Webhooks workflow

With webhooks, it's important that the URL to send the webhooks to is configured. When there is data available, Nexmo sends the webhook to your application as an HTTP request. Your application should respond with an HTTP success code to indicate that it successfully received the data.

The process looks something like this:

```js_sequence_diagram
Your App->Nexmo: Configure URL for webhook
Note over Your App, Nexmo: Some time later ...
Nexmo->Your App: Have some interesting data
Your App->Nexmo: 200 OK
```

Webhooks provide a convenient mechanism for Nexmo to send information to your application for events such as an incoming call or message, or a change in call status. They can also be used to send follow-up information such as a delivery receipt which may become available some time after the request it relates to.

## Which APIs support webhooks?

Information resulting from requests to the SMS API, Voice API, Number Insight API, US Short Codes API, and Nexmo virtual numbers are sent in an HTTP request to your webhook endpoint on an HTTP server. To configure your webhook endpoint, please visit the [Nexmo dashboard](https://dashboard.nexmo.com/settings)

Nexmo sends and retrieves the following information using webhooks:

| API Name | Webhooks usage |
|-------|--------|
| SMS API | Sends the delivery status of your message and receives inbound SMS |
| Voice API | Retrieves the [Nexmo Call Control Objects](/voice/voice-api/ncco-reference) you use to control the call from one webhook endpoint, and sends information about the call status to another. View the [Webhook Reference](/voice/voice-api/webhook-reference) for more detail. |
| Number Insight Advanced Async API | Receives complete information about a phone number |
| US Short Codes API | Sends the delivery status of your message and receives inbound SMS |

## Setting webhook endpoints

```tabbed_content
source: '_examples/concepts/guides/webhooks-setup/'
```

## Receiving webhooks

To interact with Nexmo webhooks:

1. Create a Nexmo account.
2. Write scripts to handle the information sent or requested by Nexmo. Your server must respond with a success status code (any status code between 200 OK and 205 Reset Content) to inbound messages from Nexmo.
3. Publish your scripts by deploying to a server (for local development, try [Ngrok](https://ngrok.com/)).
4. [Configure a webhook endpoint](#setting-webhook-endpoints) in the API you would like to use.
5. Take an action (such as sending an SMS) that will trigger that webhook.

Information about your request is then sent to your webhook endpoint.

## Tips for debugging webhooks

**Start simple** - Publish the simplest possible script that you can think of to respond when the webhook is received and perhaps print some debug information. This makes sure that the URL is what you think it is, and that you can see the output or logs of the application.

**Code defensively** - Inspect that data values exist and contain what you expected before you go ahead and use them. Depending on your setup, you could be open to receiving unexpected data so always bear this in mind.

**Look at examples** - Nexmo provides examples implemented with several technology stacks in an attempt to support as many developers as possible. For example code using webhooks see the following:

* [Receive an SMS](/messaging/sms/code-snippets/receiving-an-sms)
* [Handle delivery receipts](/messaging/sms/guides/delivery-receipts)
* [Receive an incoming call](/voice/voice-api/code-snippets/receive-an-inbound-call)

You can also check the Code Snippets section of the documentation for the API you are using.

## Using Ngrok for local development

Webhooks are an unusual situation for developers; often you will work on local platforms while you're getting the details worked out, but when using webhooks your webhook URLs must be publicly accessible in order for Nexmo or another service to access them. One way to work around this problem is to use a free tool called [Ngrok](https://ngrok.com/). Ngrok creates a secure tunnel to your locally-running application from the outside world. To get started with Ngrok, follow these steps:

1. Download and install Ngrok using the [instructions](https://ngrok.com/download) for your platform.
2. Start your webserver running locally, and check which port it uses (for example, if you usually use <http://localhost:3000> to access your application, then the port is 3000).
3. Create an Ngrok tunnel to this port with a command such as `ngrok http 3000`.
4. This command will show the URL of the tunnel, which will look similar to `https://abcdef1.ngrok.io`. Copy this URL.
5. Go ahead and [configure your Nexmo webhooks](#setting-webhook-endpoints) to point to this URL, and you are up and running.

> Beware that each time you start up the Ngrok tunnel, you're likely to get a new URL so don't forget to update the webhooks configuration accordingly! Paid Ngrok accounts can reserve tunnel names and choose which one to use when they start up, so you can avoid having to reconfigure your webhooks.

**Cool bonus feature of Ngrok:** in addition to the tunnel URL displayed in the command output, you will also see a URL for the "Web Interface". The web interface offers an excellent way of examining the details of all the requests received by the tunnel and the responses returned and is, therefore, a very useful debugging tool. You can also use the "Replay" button to repeat a request rather than having to send yourself lots of text messages or continuously reproduce whatever event your webhook code is responding to. These features make testing your application's response to webhooks much more convenient.

## Configuring your firewall

If you restrict inbound traffic (including delivery receipts), you need to whitelist the following IP addresses in your firewall. Inbound traffic from Nexmo might come from any of the following:

* `119.81.44.0/28`
* `169.60.146.16/28`
* `169.63.86.160/28`
* `5.10.112.112/28`
* `169.50.200.64/28`
