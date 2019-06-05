---
title: System Overview
navigation_weight: 1
---

# System Overview

To understand the relationships between the different components in the system and between the Nexmo APIs, consider an example of making a call from a phone to an app user:

![Programmable Conversation Architecture](/assets/images/conversation-api/conv-diagram-arch.gif)

1. A call is placed to a [Nexmo number](/numbers/overview), which was [assigned to a Nexmo Application](/numbers/guides/number-management).

2. Nexmo receives the call and triggers your Nexmo Application’s [`answer_url` webhook](/voice/voice-api/webhook-reference#answer-webhook), which your backend expose.

3. That `answer_url` determines how to handle a call, and who to connect the call to. It does that by executing an NCCO, that utilizes Nexmo [Voice API numerous capabilities](](/voice/voice-api/ncco-reference)).

4. A [call](/concepts/call) is created, and the requested users are connected to is.

    * A [call](/concepts/call), as other Nexmo communication events, happen on top of a [Conversation](/concepts/conversation). As a result of `answer_url` execution, a new [Conversation](/concepts/conversation) is created, or an existing one is fetched, and the requested users are added to it to connect to the call.

> **Notice that** the events are passing through `Conversation API` and are accessible to you through it. For that reason, Conversations are very powerful, as they hold all the communication events of all [channels](/conversation/concepts/channel) per user, allowing you to keep the communication context. Just imagine how much can you learn about your users and improve the communication between them and with them!

5. All the respective events are dispatched to your applications:

    * **To your backend**, via [`event_url` webhooks](/application/overview#webhooks), that you could assign to your Nexmo application:

        * Events to [voice `event_url` webhook](/voice/voice-api/webhook-reference#event-webhook) are dispatched by Voice API

        * Events to rtc `event_url` webhook are dispatched by Conversation API


    * **To your client-side application**, which [integrated the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/android)

        * Via callbacks that the SDKs trigger if a user is logged in to the SDK

        * Via push notifications, if [have been enabled](/client-sdk/setup/set-up-push-notifications), and the app is in the background

> **Note:** only selected events are dispatched to the SDKs. In order to receive all events, make sure to [set `event_url`s to your Nexmo Application.](application/overview#webhooks) Those are not mandatory but highly recommended.

## Reference

* [Conversation API Reference](/api/conversation)

* [Client SDK](/client-sdk/overview)

* [Voice API](/voice/voice-api/overview)