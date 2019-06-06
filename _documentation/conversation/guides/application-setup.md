---
title: How to set up your application
navigation_weight: 1
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

    b. Set `event_url` [webhook](/voice/voice-api/webhook-reference#event-webhook) for your Nexmo application's voice capability to receive the voice events that are dispatched by Voice API. This step is optional but recommended.

    c. Set `event_url` [webhook](/application/overview#webhook-types) for your Nexmo application's RTC capability to receive the RTC events that are dispatched by Conversation API. This step is optional but recommended.
    
    d. Create [Users](/conversation/concepts/user) using the Conversation API.

    e. Generate JWTs that are used to authorize your Users when performing Conversation API calls, or when logging in to the [Client SDKs](/client-sdk/setup/add-sdk-to-your-app).

    f. Use [Conversation API](/conversation/api-reference) or other Nexmo API capabilities as required. For example, to create conversations, and send events. You can also analyze your user's communication behavior and reach interesting conclusions on how to better engage with them. This step is optional but recommended.

4. Now you can create a client-side application and [integrate the Nexmo Client SDK](/client-sdk/setup/add-sdk-to-your-app/). Using the Client SDK your client app will be able to:

* Log in a User
* Create and join Conversations
* Start and answer phone and in-app calls
* Send in-app messages

## Reference

For further information see the following documentation:

### Guides

* [User authentication](/conversation/guides/user-authentication)
* [Event flow](/conversation/guides/event-flow)

### API Refrences

* [Conversation API](/api/conversation)
* [Client SDK](/client-sdk/overview)
* [Voice API](/voice/voice-api/overview)

