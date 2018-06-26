---
title: Webhooks
description: How to set and use webhook endpoints for the Nexmo APIs.
---

# Webhooks

## What is a webhook?

A [webhook](https://en.wikipedia.org/wiki/Webhook) is a callback sent via HTTP to a URL of your choice. It is a simple way of enabling communication from our servers to yours. Nexmo uses webhooks to notify you about incoming calls and messages, events in calls and delivery receipts for messages.

## Which APIs support webhooks?

Information resulting from requests to the SMS API, Voice API, Number Insight API, US Short Codes API and Nexmo virtual numbers is sent in an HTTP request to your webhook endpoint on an HTTP server.

Nexmo sends and retrieves the following information using webhooks:

* SMS API - sends the delivery status of your message and receives inbound SMS
* Voice API - retrieves the [Nexmo Call Control Objects](/voice/voice-api/ncco-reference) you use to control the call from one webhook endpoint, and sends information about the call status to another
* Number Insight Advanced Async API - receives complete information about a phone number
* US Short Codes API - sends the delivery status of your message and receives inbound SMS

⚓️Setting the webhook endpoint for the Nexmo APIs
## Setting webhook endpoints

```tabbed_content
source: '_examples/concepts/guides/webhooks-setup/'
```
⚓️Working with the Nexmo webhooks
## Receiving webhooks

To interact with Nexmo webhooks:

1. Create a Nexmo account.
2. Write scripts to handle the information sent or requested by Nexmo. Your server must respond with ^[success status code](Any status code between 200 OK and 205 Reset Content) to inbound messages from Nexmo.
3. Put your scripts on your HTTP server.
4. Send a *request* with the [webhook endpoint](#setting) set.

Information about your request is then sent to your webhook endpoint.

The following code examples are webhooks for the SMS API:

```tabbed_examples
source: '_examples/messaging/webhooks/inbound'
```

## Configuring your firewall
If you restrict inbound traffic (including delivery receipts), you need to whitelist the following IP addresses in your firewall. Inbound traffic from Nexmo might come from any of the following:

* `174.37.245.32/29`
* `174.36.197.192/28`
* `173.193.199.16/28`
* `119.81.44.0/28`
