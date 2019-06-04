---
title: System Overview
---

# System Overview

To understand the relationships between the different components in the system and between the Nexmo APIs, consider an example of placing a phone call to an app User.

![Programmable Conversation Architecture](/assets/images/conversation-api/conv-diagram-arch.gif)

* A [Call](/concepts/call) is placed to a [Nexmo number](/numbers/overview), which was [assigned to a Nexmo Application](/numbers/guides/number-management).

* Nexmo receives the Call and triggers your Nexmo Application’s [`answer_url` webhook](/voice/voice-api/webhook-reference#answer-webhook), which your backend should expose.

* That `answer_url` determines how to handle a call, and who to connect to. It does that by executing an NCCO, that can utilize Nexmo [Voice API numerous capabilities](](/voice/voice-api/ncco-reference)).

* Voice API tells Conversation API which users should be connected and how. Then, the respective events are dispatched to your applications:

    * To your backend, via [`event_url` webhooks](/application/overview#webhooks), that you could assign to your Nexmo application
        
        * Events to [voice `event_url` webhook](/voice/voice-api/webhook-reference#event-webhook) are dispatched by Voice API

        * Events to rtc `event_url` webhook are dispatched by Conversation API


    * To your client-side application, which [integrated the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/android)

        * Via callbacks that the SDKs trigger if a user is logged in to the SDK

        * Via push notifications, if [have been enabled](/client-sdk/setup/set-up-push-notifications), and the app is in the background.

> **Note:** only selected events are dispatched to the SDKs. In order to receive all events, make sure to [set `event_url`s to your Nexmo Application.](application/overview#webhooks) Those are not mandatory but highly recommended.


> **Notice that** all the events are passing through `Conversation API`. Even Calls are implemented on top of a [Conversation](/conversation/concepts/conversation). For that reason, Conversations are very powerful, as they hold all the communication events in all [channels](/conversation/concepts/channel) per user. Just imagine how much can you learn about your Users and improve the communication between them and with them!

## Reference

* [Conversation API Reference](/api/conversation)

* [Client SDK](/client-sdk/overview)

* [Voice API](/voice/voice-api/overview)