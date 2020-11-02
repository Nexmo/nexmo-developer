---
title: Webhooks
description: How to set and use webhook endpoints for the Vonage APIs.
navigation_weight: 5
---

# Webhooks

Webhooks are an extension of an API, but instead of your code requesting data from our API platform, Vonage sends the data to you. The data arrives in a web request to your application. A webhook may be the result of an earlier API call (this type of webhook is also called a "callback"), such as an asynchronous request to the Number Insight API. Webhooks are also used to notify your application of events such as an incoming call or message.

Since the Vonage servers need to be able to send data to your application via webhooks, you need to set up a webserver to receive the incoming HTTP requests. You also need to specify the URL of each webhook on your webserver so that data can be sent to each one.

## Webhooks workflow

With webhooks, it's important that the URL to send the webhooks to is configured. When there is data available, Vonage sends the webhook to your application as an HTTP request. Your application should respond with an HTTP success code to indicate that it successfully received the data.

The process looks something like this:

```sequence_diagram
Your App->>Vonage: Configure URL for webhook
Note over Your App, Vonage: Some time later ...
Vonage->>Your App: Sending some interesting data
Your App->>Vonage: 200 OK - I got it, thanks
```

Webhooks provide a convenient mechanism for Vonage to send information to your application for events such as an incoming call or message, or a change in call status. They can also be used to send follow-up information such as a delivery receipt which may become available some time after the request it relates to.

## Which APIs support webhooks?

Information resulting from requests to the SMS API, Voice API, Number Insight API, US Short Codes API, and Vonage virtual numbers are sent in an HTTP request to your webhook endpoint on an HTTP server. To configure your webhook endpoint, please visit the [Vonage dashboard](https://dashboard.nexmo.com/settings)

Vonage sends and retrieves the following information using webhooks:

| API Name                          | Webhooks usage                                                                                                                                                                                                                                                               |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SMS API                           | Sends the delivery status of your message and receives inbound SMS                                                                                                                                                                                                           |
| Voice API                         | Retrieves the [Nexmo Call Control Objects](/voice/voice-api/ncco-reference) you use to control the call from one webhook endpoint, and sends information about the call status to another. View the [Webhook Reference](/voice/voice-api/webhook-reference) for more detail. |
| Number Insight Advanced Async API | Receives complete information about a phone number                                                                                                                                                                                                                           |
| US Short Codes API                | Sends the delivery status of your message and receives inbound SMS                                                                                                                                                                                                           |
| Client SDK/Conversation API       | Real-time Communication (RTC) events are sent to the RTC event webhook                                                                                                                                                                                                       |
| Message and Dispatch APIs         | Supports both inbound message and message status webhooks                                                                                                                                                                                                                    |

## Setting webhook endpoints

```tabbed_content
source: '_examples/concepts/guides/webhooks-setup/'
```

## Receiving webhooks

To interact with Vonage webhooks:

1. Create a Vonage account.
2. Write scripts to handle the information sent or requested by Vonage. Your server must respond with a success status code (any status code between 200 OK and 205 Reset Content) to inbound messages from Vonage.
3. Publish your scripts by deploying to a server (for local development, try [Ngrok](https://ngrok.com/)).
4. [Configure a webhook endpoint](#setting-webhook-endpoints) in the API you would like to use.
5. Take an action (such as sending an SMS) that will trigger that webhook.

Information about your request is then sent to your webhook endpoint.

## Testing webhooks locally

In order to test the correct functioning of webhooks on your locally running application, you will need to create a secure tunnel between Vonage and your application. You can do this with a secure tunnel application such as [Ngrok](https://ngrok.com). See the [Testing with Ngrok](/tools/ngrok) topic for more information.

## Configuring your firewall

If you restrict inbound traffic (including delivery receipts), you need to add the Vonage IP addresses to your firewall's list of approved IP addresses. You can find more information how to do this in our knowledge base:

* [Voice IP Ranges](https://help.nexmo.com/hc/en-us/articles/115004859247)
* [SMS IP Ranges](https://help.nexmo.com/hc/en-us/articles/204015053)
* [Messages and Dispatch IP Ranges](https://help.nexmo.com/hc/en-us/articles/360035845911)

## Tips for debugging webhooks

**Start simple** - Publish the simplest possible script that you can think of to respond when the webhook is received and perhaps print some debug information. This makes sure that the URL is what you think it is, and that you can see the output or logs of the application.

**Code defensively** - Inspect that data values exist and contain what you expected before you go ahead and use them. Depending on your setup, you could be open to receiving unexpected data so always bear this in mind.

**Look at examples** - Vonage provides examples implemented with several technology stacks in an attempt to support as many developers as possible. For example code using webhooks see the following:

* [Receive an SMS](/messaging/sms/code-snippets/receiving-an-sms)
* [Handle delivery receipts](/messaging/sms/guides/delivery-receipts)
* [Receive an incoming call](/voice/voice-api/code-snippets/receive-an-inbound-call)

You can also check the code snippets section of the documentation for the API you are using.

## See also

* More information on webhook types and application capabilities can be found in the [Application documentation](/application/overview).
