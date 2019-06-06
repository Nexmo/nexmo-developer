---
title: Call flow overview
description: This topic provides an overview of a voice call flow through the system encompassing the Nexmo Voice and Conversation services.
navigation_weight: 5
---

# Call flow overview

To understand the relationships between the different components in the system and between the Nexmo APIs, consider the system flow for an example of making a call from a phone to an app user. This flow is summarized here:

1. A voice call is initiated.
2. Nexmo receives the call and calls back on the `answer_url` webhook.
3. An NCCO is optionally executed.
4. A call object is created and users connected into it.
5. Events are dispatched.

This is illustrated in the following diagram:

![Programmable Conversation Architecture](/assets/images/conversation-api/conv-diagram-arch.gif)

This sequence of events is explained in the following section.

1. A call is placed to a [Nexmo number](/numbers/overview), which was [assigned to a Nexmo Application](/numbers/guides/number-management).

2. Nexmo receives the call and triggers your Nexmo Application’s [`answer_url` webhook](/voice/voice-api/webhook-reference#answer-webhook), which your backend expose.

3. That `answer_url` determines how to handle a call, and who to connect the call to. It does that by executing an NCCO, that utilizes Nexmo [Voice API numerous capabilities](/voice/voice-api/ncco-reference).

4. A [Call](/conversation/concepts/call) is created, and the requested users are connected into it. A [call](/conversation/concepts/call) object, as with Nexmo communication events, occur within a [Conversation](/conversation/concepts/conversation) object. As a result of `answer_url` execution, a new [Conversation](/conversation/concepts/conversation) is created, or an existing one is fetched, and the requested users are added to it to connect to the call. Note, the events are passing through the Conversation Service and are accessible to you through the Conversation API. For that reason, Conversations are very powerful, as they hold all the communication events of all [channels](/conversation/concepts/channel) per user, allowing you to retain the communication context.

5. All the respective events are dispatched to your application. These events can be inbound to the backend or to the client app:

    a. **To your backend** via [`event_url` webhooks](/application/overview#webhooks), that you could assign to your Nexmo application. There are both Voice events and RTC events. Events to [voice `event_url` webhook](/voice/voice-api/webhook-reference#event-webhook) are dispatched by Voice API. Events to the RTC `event_url` webhook are dispatched by Conversation API.

    b. **To your client-side application**, which is [integrated with the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/android). These events can be received via callbacks that the Client SDKs trigger if a user is logged in to the SDK. They can also be received via push notifications, if they [have been enabled](/client-sdk/setup/set-up-push-notifications), and the app is in the background.

> **Note:** Only selected events are dispatched to the Client SDKs. In order to receive all events, make sure you [set `event_url` webhooks for your Nexmo Application](application/overview#webhooks). Setting of event webhooks is not mandatory but is highly recommended.

## Reference

For further information see the following documentation:

* [Conversation API](/api/conversation)
* [Voice API](/voice/voice-api/overview)
* [Client SDK](/client-sdk/overview)
