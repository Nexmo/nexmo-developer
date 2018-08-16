---
title: Webhooks
description: How to set and use webhook endpoints for the Nexmo APIs.
navigation_weight: 5
---

# Webhooks

Webhooks are an extension of an API, but instead of your code requesting data from Nexmo, instead Nexmo sends data to you. The data arrives in a web request to your own application. A webhook may be a result of an earlier API call (this type of webhook is also called a "callback"), such as an asynchronous request to the Number Insight API. Webhooks are also used to notify your application of events such as an incoming call or message.

There many similarities between APIs and webhooks; there are also some big differences! Since the Nexmo servers need to be able to send data to your application, to use webhooks you need to set up a webserver to receive the incoming HTTP requests. You will also need to give the URL of that webserver to Nexmo so that we know where your data should be sent to.

## Webhooks workflow

With webhooks, it's important that the URL to send the webhooks to is configured. When there is data available, Nexmo sends the webhook to your application as an HTTP request. Your application should respond with an HTTP success code to indicate that it successfully received the data.

The process looks something like this:

```js_sequence_diagram
Your App->Nexmo: Configure URL for webhook
Note over Your App, Nexmo: Some time later ...
Nexmo->Your App: Have some interesting data
Your App->Nexmo: 200 OK
```

Webhooks are a great way for Nexmo to send information about events such as an incoming call or message, an event during a call, or to send follow-up information such as a delivery receipt which may become available some time after the request it relates to. You will see webhooks used in a few of our applications.

## Which APIs support webhooks?

Information resulting from requests to the SMS API, Voice API, Number Insight API, US Short Codes API and Nexmo virtual numbers is sent in an HTTP request to your webhook endpoint on an HTTP server.

Nexmo sends and retrieves the following information using webhooks:

| API Name | Webhooks usage |
|-------|--------|
| SMS API | sends the delivery status of your message and receives inbound SMS |
| Voice API | retrieves the [Nexmo Call Control Objects](/voice/voice-api/ncco-reference) you use to control the call from one webhook endpoint, and sends information about the call status to another |
| Number Insight Advanced Async API | receives complete information about a phone number |
| US Short Codes API | sends the delivery status of your message and receives inbound SMS |

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

### Tips for debugging webhooks

**Start simple** Publish the simplest possible script that you can think of to respond when the webhook is received and perhaps print some debug information. This makes sure that the URL is what you think it is, and that you can see the output or logs of the application.

**Code defensively** Inspect that data values exist and contain what you expected before you go ahead and use them. Depending on your setup, you could be open to receiving unexpected data so always bear this in mind.

**Look at examples** We publish our examples in a few different technology stacks in an attempt to support as many developers as possible. For good webhook example code, how about one of these: [receive an SMS](/messaging/sms/building-blocks/receiving-an-sms), [handle delivery receipts](/messaging/sms/guides/delivery-receipts), [receive an incoming call](/voice/voice-api/building-blocks/receive-an-inbound-call) - or check the "building blocks" examples for the API you are using.

## Configuring your firewall

If you restrict inbound traffic (including delivery receipts), you need to whitelist the following IP addresses in your firewall. Inbound traffic from Nexmo might come from any of the following:

* `174.37.245.32/29`
* `174.36.197.192/28`
* `173.193.199.16/28`
* `119.81.44.0/28`
* `5.10.112.112/28`
