---
title: Event flow
description: This topic provides an overview of a event dispatching flow through the system encompassing the Nexmo Voice and Conversation services.
navigation_weight: 4
---

# Event Flow

To understand the relationships between the different components in the system and between the Nexmo APIs, consider the system flow of event dispatching.

To illustrate, consider the use case of a making a call from a phone to an app user.

This flow is summarized here:

1. A phone call is initiated.
2. Nexmo receives the call and calls back on the `answer_url` webhook.
3. An NCCO is executed.
4. A call is created and users connected into it.
5. Events are dispatched.

> **Note:** in the mentioned use case the entry point is a phone call to a Nexmo number. However, the diagram below and the way events are dispatched in the system, works in a similar manner for all other event type.

This is illustrated in the following diagram:

<!--![Programmable Conversation Architecture](/assets/images/conversation-api/conv-diagram-arch.gif)-->
```sequence_diagram
    participant Client
    participant Application
    participant Conversation API
    participant Voice API
    participant Backend
    Note over Client, Backend: Establish Conversation
    Client-->>Application: 1. Calls Nexmo number
    Application-->>Backend: 2. Establishes `answer_url `and `event_url` webhooks
    Backend-->>Voice API: 3. `answer_url` returns NCCO 
    Voice API-->>Conversation API: 4. Call is created and Users added
    Note over Client, Backend: Handle events
    rect rgba(197, 207, 209, .2)
        Voice API-->> Backend: 5a. Voice API events trigger`event_url`
        Conversation API-->>Backend: 5b. RTC events trigger `event_url`
        Conversation API-->>Client: 5c. Events sent to your app via Client SDK
    end

```
  
  
  
  
The sequence is as follows:

1. A call is placed to a [Nexmo number](/numbers/overview), which was [assigned to a Nexmo Application](/numbers/guides/number-management).

2. Nexmo receives the call and triggers your Nexmo Application’s [`answer_url` webhook](/voice/voice-api/webhook-reference#answer-webhook), which your backend exposes.

3. That `answer_url` determines how to handle a call, and who to connect the call to. It does that by executing an NCCO, that utilizes Nexmo [Voice API numerous capabilities](/voice/voice-api/ncco-reference).

4. A [call](/conversation/concepts/call) is created, and the requested users are connected into it. A call, as with Nexmo communication events, occur within a [Conversation](/conversation/concepts/conversation) object.
As a result of `answer_url` execution, a new [Conversation](/conversation/concepts/conversation) is created, or an existing one is fetched, and the requested users are added to it to connect to the call. Note, all of the events are passing through the Conversation API and are accessible to you through it. For that reason, Conversations are very powerful, as they hold all the communication events of all [channels](/conversation/concepts/channel) per user, allowing you to retain the communication context, and provide better and smarter communication experiences for your users.

5. All the respective events are dispatched to your application. These events can be inbound to the backend or to the client app:

    a. and b. **To your backend** via [`event_url` webhooks](/application/overview#webhooks), that you could assign to your Nexmo application. There are both Voice events and RTC events. Events to your Nexmo application's [voice `event_url` webhook](/voice/voice-api/webhook-reference#event-webhook) are dispatched by Voice API. Events to your Nexmo application's RTC capability `event_url` webhook are dispatched by Conversation API.

    c. **To your client-side application**, which is [integrated with the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/android). These events can be received via callbacks that the Client SDKs trigger if a user is logged in to the SDK. They can also be received via push notifications, if they [have been enabled](/client-sdk/setup/set-up-push-notifications), and the app is in the background.

> **Note:** Only selected events are dispatched to the Client SDKs. In order to receive all events, make sure you [set `event_url` webhooks for your Nexmo Application](/application/overview#webhooks). Setting of event webhooks is not mandatory but is highly recommended.

## Reference

For further information see the following documentation:

### Guides

* [Application setup](/conversation/guides/application-setup)
* [User authentication](/conversation/guides/user-authentication)

### API References

* [Conversation API](/api/conversation)
* [Client SDK](/client-sdk/overview)
* [Voice API](/voice/voice-api/overview)
