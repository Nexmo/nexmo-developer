---
title: Set Up
---

# Set Up

In order to set up your Programmable Conversation Application, you need to:

![Programmable Conversation Set Up](/assets/images/conversation-api/conv-diagram-setup.gif)

1. [Create a Nexmo Application](/application/overview#creating-applications)

2. [Rent and assign a Nexmo number to you Nexmo Application](/numbers/guides/number-management#rent-a-virtual-number)

3. Build a backend service that will: 

    * Set an `answer_url` webhook, to define the behavior when a new call is taking place

    * (Optional but very recommended) set[`event_url` webhooks](/application/overview#webhooks), and assign to your Nexmo application

        * Events to [voice `event_url` webhook](/voice/voice-api/webhook-reference#event-webhook) are dispatched by Voice API

        * Events to rtc `event_url` webhook are dispatched by Conversation API

* Create [Users](/conversation/concepts/user) via Conversation API.

* Generate JWTs that are used to authorize your Users when logging in and connecting to the [Client SDKs](/client-sdk/setup/add-sdk-to-your-app/android)

* [Optional] Use any other [Conversation API](/conversation/api-reference) (or another Nexmo API) capabilities. For example, to create conversations, send events, analyze your users communication behavior and make interesting conclusions on how to better engage with them, and more.  

4. Create a client-side application and [integrate Nexmo Client SDK.]((/client-sdk/setup/add-sdk-to-your-app/)). Your client will be able to:

    * Log in a User
    * Create and join Conversations
    * Start and answer phone and in-app calls
    * Send in-app messages
    * and much more...
