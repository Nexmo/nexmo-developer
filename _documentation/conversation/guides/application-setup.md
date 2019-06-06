---
title: How to set up your application
navigation_weight: 3
---

# How to set up a Conversation API application

In order to set up your Conversation API application, you typically need to carry out the following steps:

1. Create a Nexmo application
2. Rent and assign a Nexmo number
3. Build a backend service
4. Create a client-side application (possibly using the Client SDK)

This process is illustrated in the following diagram:

![Application setup](/assets/images/conversation-api/conv-diagram-setup.gif)

1. [Create a Nexmo Application](/application/overview#creating-applications).

2. [Rent and assign a Nexmo number](/numbers/guides/number-management#rent-a-virtual-number) to your Nexmo Application.

3. Build a backend service that will:

    a. Set an `answer_url` [webhook](/application/overview#webhooks) to define the behavior when a new call is taking place.

    b. Set event webhooks `event_url` for your Nexmo application. Voice events are dispatched to the voice event [webhook](/voice/voice-api/webhook-reference#event-webhook). RTC events are dispatched by the Conversation Service to the [RTC webhook](/application/overview#webhook-types). This step is optional but recommended.

    c. Create [Users](/conversation/concepts/user) using the Conversation API.

    d. Generate JWTs that are used to authorize your Users when logging in and connecting to the [Client SDKs](/client-sdk/setup/add-sdk-to-your-app).

    e. Use [Conversation API](/conversation/api-reference) or other Nexmo API capabilities as required. For example, to create conversations, and send events. You can also analyze your user's communication behavior and reach interesting conclusions on how to better engage with them. This step is optional but recommended.

4. Create a client-side application and [integrate the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/). Using the Client SDK your client app will be able to:

* Log in a User
* Create and join Conversations
* Start and answer phone and in-app calls
* Send in-app messages
