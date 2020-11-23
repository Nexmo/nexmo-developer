---
title: Overview
meta_title: Application version 2 Overview
Description: A Vonage API application contains the security and configuration information you need to connect to Vonage endpoints and use the Vonage APIs. 
navigation_weight: 1
---

# Overview

> **NOTE:** This section of the docs describes [Applications V2](/api/application.v2) functionality.

A Vonage API application contains the security and configuration information you need to connect to Vonage endpoints and use the Vonage APIs.

Each Vonage application created can support multiple capabilities - for example you can create an Application that supports using the Voice, Messages and RTC APIs.

![Application Overview](/images/vonage_application_v2.png "Application Overview")

To illustrate the use of Vonage applications, a brief summary for creating and using a Vonage voice application is given here:

1. Create a Vonage application using the CLI, the Dashboard or the Application API.
2. Make sure you configure your webhook URLs. Vonage will call back on these URLs with important information.
3. Associate a Vonage number with your Vonage application.
4. Write your web application. Implement the webhook endpoints you configured in step 2, using the Vonage APIs as required.

For instance, if you want to create an application that [forwards inbound calls](/voice/voice-api/code-snippets/connect-an-inbound-call) to a destination phone, you would perform the following steps:

1. You create a Vonage application that has voice capabilities.
2. You configure the answer and event webhook URLs.
3. You associate a Vonage number with your Vonage application.
4. You implement a web application that responds to callbacks on the webhook URLs.
5. When an inbound call is made to the Vonage number associated with the Vonage application, an [NCCO](/voice/voice-api/ncco-reference) is returned on the `answer_url`.

Other types of application, such as those with Messages and Dispatch capabilities, have a slightly different process which is described in the relevant sections of this [documentation](/application/overview).

The following sections explain Vonage applications in more detail.

## Structure

Each application has the following:

Name | Description
-- | --
`id` | Used to identify each application and used in conjunction with `private_key` to generate JWTs.
`name` | The application name.
`capabilities` | Describes the types of functionality this application will support. The capabilities `voice`, `messages`, `rtc`, `vbc`. Any number of these capabilities can be supported in one application. You also set `webhooks` for each capability specified. Vonage sends and retrieves information via the webhook endpoints.
`keys` | Contains `private_key` and `public_key`. You use the private key to generate the JWTs used to authenticate your calls to the Vonage APIs. The public key is used by Vonage to authenticate the JWT in your requests to Vonage API.

## Capabilities

A Vonage application can use various APIs, including Voice, Messages and Dispatch, Conversation, and Client SDK.

When creating an application you can specify the capabilities you want your application to support. For each capability you can set webhooks depending on what capabilities you want, for example for an application with an `rtc` capability you could specify an event URL to receive RTC events. If your application also needed to use `voice` capabilities you could also potentially set an Answer URL to receive a call answered webhook, a fallback URL in case your Answer URL fails, and another Event URL to receive voice call related events.

A summary of capabilities is given in the following table:

Capability | Description
---|---
`voice` | Used to support Voice capabilities.
`messages` | Used to support Messages and Dispatch API capabilities.
`rtc` | Used to support WebRTC capabilities. Typically for use with Client SDK.
`vbc` | Used to determine pricing, but currently has no other capabilities.

## Webhooks

The webhook URLs you provide when creating an application depend on the application capabilities required. The following table summarizes the webhooks:

Capability | API used | Webhooks available
--- | --- | ---
`voice` | Voice | `answer_url`, `fallback_answer_url`, `event_url`
`messages` | Messages and Dispatch | `inbound_url`, `status_url`
`rtc` | Client SDK | `event_url`
`vbc` | VBC | None

## Webhook types

The following table describes webhooks available per capability:

Capability | Webhook | API | Example | Description
--- | --- | --- | --- | --- |
`voice` | `answer_url` | [Voice](/voice/voice-api/overview) | https://example.com/webhooks/answer | The URL that Vonage make a request to when a call is placed/received. Must return an NCCO.
`voice` | `fallback_answer_url` | [Voice](/voice/voice-api/overview) | https://example.com/webhooks/fallback | If the `fallback_answer_url` is set, Vonage makes a request to it if the `answer_url` is offline or returns an HTTP error code or the `event_url` is offline or returns an error code and an event is expected to return an NCCO. The `fallback_answer_url` must return an NCCO. If your `fallback_answer_url` fails after two attempts for an initial NCCO, the call is ended. If your `fallback_answer_url` fails after two attempts for a call in progress, the call flow is continued.
`voice` | `event_url` | [Voice](/voice/voice-api/overview) | https://example.com/webhooks/event | Vonage will send call events (e.g. ringing, answered) to this URL.
`messages` | `inbound_url` | [Messages](/messages/overview), [Dispatch](/dispatch/overview) | https://example.com/webhooks/inbound | Vonage will forward inbound messages to this URL.
`messages` | `status_url` | [Messages](/messages/overview), [Dispatch](/dispatch/overview) | https://example.com/webhooks/status | Vonage will send message status updates (for example, `delivered`, `seen`) to this URL.
`rtc` | `event_url` | [Client SDK](/client-sdk/overview), [Conversation](/conversation/overview) | https://example.com/webhooks/rtcevent | Vonage will send RTC events to this URL.
`vbc` | None | [Voice endpoint](/voice/voice-api/ncco-reference#connect) | None | Not used

## Webhook timeouts

For the `voice` capability only, you can set timeouts on webhooks. There are two timeouts that can be specified: `connection_timeout` and `socket_timeout`. These parameters apply to the `answer`, `event`, and `fallback` webhooks, and are specified in milliseconds. The following table provides further information:

Parameter | Example | Description
----|----|----
`connection_timeout` | `1000` | If Vonage can't connect to the webhook URL for this specified amount of time, then Vonage makes one additional attempt to connect to the webhook endpoint. This is an integer value specified in milliseconds.
`socket_timeout` | `3000` | If a response from the webhook URL can't be read for this specified amount of time, then Vonage makes one additional attempt to read the webhook endpoint. This is an integer value specified in milliseconds.

When creating or updating an application these can be set directly, or updated as required, for example:

``` json
...
  "capabilities": {
    "voice": {
      "webhooks": {
        "answer_url": {
          "address": "https://example.com/webhooks/answer",
          "http_method": "POST",
          "connection_timeout": 500,
          "socket_timeout": 3000
        },
        "fallback_answer_url": {
          "address": "https://fallback.example.com/webhooks/answer",
          "http_method": "POST",
          "connection_timeout": 500,
          "socket_timeout": 3000
        },
        "event_url": {
          "address": "https://example.com/webhooks/event",
          "http_method": "POST",
          "connection_timeout": 500,
          "socket_timeout": 3000
        }
      }
    }
...
```

If these values are not specified when creating or updating the application, then default values are applied. The default values for these timeouts depend on the webhook concerned, as shown in the following table:

Webhook | Default `connection_timeout` | Default `socket_timeout`
----|----|----
`answer` | 1000 | 5000
`event` | 1000 | 10000
`fallback` | 1000 | 5000

> **NOTE:** Timeouts are specified in milliseconds.

There is further explanation of webhook timeouts in the [webhook documentation](/concepts/guides/webhooks#webhook-timeouts).

## Creating applications

There are four main ways to create an application:

1. In the Vonage [Dashboard](https://dashboard.nexmo.com). Applications are then listed in the [your applications](https://dashboard.nexmo.com/applications) section of the Dashboard.
2. Using the [Nexmo CLI](/application/nexmo-cli).
3. Using the [Application API](/api/application.v2).
4. Using one of the Vonage [Server SDKs](/tools).

## Managing applications using the CLI

* [Managing applications using the Nexmo CLI](/application/nexmo-cli)

## Code Snippets

```code_snippet_list
product: application
```

## Reference

* [Application API](https://developer.nexmo.com/api/application.v2)
