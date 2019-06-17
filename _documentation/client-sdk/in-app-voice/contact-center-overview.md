---
title: Contact Center Use Case
products: 
    - client-sdk
    - conversation
    - voice/voice-api
description: How to build your own contact center application.
navigation_weight: 4
---

# Build Your Own Contact Center

## Overview

In these guide, you’ll learn how to build an application with contact center features.

Your contact center application has 2 agents: `Jane` and `Joe`, that are users of your client side application. Your agents makes and receives in-app calls, whereas the caller can use a regular phone.

To achieve this, this guide consist of three parts your should implement:

1. **A server-side application**, for fundamental server-side functionalities, such as managing users and authorization. This is implemented with[Conversation API.](/conversation/overview).

2. **A client side application**, for your contact center users to log in, make and receive calls. This can be a web, iOS or Android application, which integrates [Nexmo Client SDK](/client-sdk/in-app-voice/overview).

3. Adding advanced voice capabilities, utilizing Nexmo [Voice API](/voice/voice-api/overview) on your backend side application.

> **NOTE:** Under the hood, Nexmo Voice API and Client SDK both use Conversation API. That means that all communication is done over a [Conversation](/conversation/concepts/conversation). That allows you to maintain the communication context of your users, for any communication channel. All of the Conversations and the [Events](/conversation/concepts/event) are accessible for you to utilize, through [Conversation API](/conversation/overview).

## Before You Begin

Make sure you have a Nexmo account, or [sign up](https://dashboard.nexmo.com/) to get started for free!

## Set Up Your Backend

To use the Client SDK you must have a backend application that uses [Conversation API.](/conversation/overview). Some functionality, like managing users can only be done through the backend. Other capabilities, such as creating Conversations, can be done by both client and server side.

### 1. Deploy Your Server Side Application

You may implement any backend that you'd like to use for [the required Conversation API functionality](/conversation/guides/application-setup).

However, to help you get started with this guide, you can use our demo sample backend application.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/nexmo-community/contact-center-rails)

You are welcome to explore and edit the project, which is open sourced on [GitHub](https://github.com/nexmo-community/contact-center-rails)

### 2. Create Nexmo Application

Once you have created a Nexmo Account you will be able to create multiple [Nexmo Applications](conversation/concepts/application). A Nexmo Application can contain a unique set of [Users](conversation/concepts/user) and [Conversations](conversation/concepts/conversation).

After deploying the demo backend application on the previous step, you will need to:

1. Log in using your *api key* and *api secret*, which you can obtain from [Nexmo Dashboard](https://dashboard.nexmo.com/)
![Login](/assets/images/client-sdk/contact-center/login.png)

2. Create a new Nexmo Application by typing an application name and clicking *Create*
![Setup](/assets/images/client-sdk/contact-center/setup.png)

> That uses [Nexmo Applications API](/concepts/guides/applications/curl#getting-started-with-applications)

### 3. Connect a Nexmo Number

In order to make and receive calls, you should rent a [Nexmo Number](/numbers/overview) and connect it to your Nexmo Application.

Use our demo backend application, navigate to the **Numbers** tab on the top bar, and search for a number.

![Number search](/assets/images/client-sdk/contact-center/numbers-search.png)

After you rented the number, assign it to the Nexmo Application you've created.

![Number assign](/assets/images/client-sdk/contact-center/numbers.png).

> For more features and number management, read more on [Numbers API](/numbers/overview) or visit the [dashboard](https://dashboard.nexmo.com/buy-numbers).

### 4. Create Users

A [user](/conversation/concepts/user) can log in to your application in order create a conversation, join a conversation, make and receive calls and more.

One the demo backend application, on the top menu select **Users** and then **New User**.

![New User](/assets/images/client-sdk/contact-center/users-new.png)

> That uses [Conversation API](https://developer.nexmo.com/api/conversation#createUser).

For the purpose of this guide, create two users one with the name `Jane` and another user with the name `Joe`. Each ewpresents an agent that can log in to your contact center application.

### 5. Authenticate Users

The Nexmo Client SDK uses [JWTs](https://jwt.io/) to authenticate a user when logging in to the SDK and the API. These JWTs are generated using the application ID and private key that is provided when a new Nexmo application is created.

For security reasons, your client should not hold your private key. Therefore, the JWT must be provided by your backend.

Your backend should expose an endpoint that would allow the client side app to request a valid JWT per user. In a real life scenario, you would probably add additional authentication system, inorder to ensure the identity of the user who is attempts to log in to your app.

For the purpose of this guide, the backend demo application exposes a simple endpoint that only uses the username:

```
GET YOUR_BACKEND/api/jwt
```

>More information on implementing the authentication system for a real life use case, [read in this topic](/conversation/guides/user-authentication). 
>Read more about JWT and ACL [in this topic](/conversation/concepts/jwt-acl).

## Set Up Your Client Side Application

### 1. Choose Your Client App

Nexmo Client SDK supports web (Javascript), iOS and Android.

You may [integrate the SDK](client-sdk/setup/add-sdk-to-your-app) to your own client side application and [add in-app voice functionality](/client-sdk/in-app-voice/guides/start-and-receive-calls)

However, to easily get started you may clone and run one of the demo client side applications:

* Javascript //TODO: add links
* iOS: [Swift](https://github.com/nexmo-community/contact-center-swift) or [Objective-C](https://github.com/nexmo-community/contact-center-objective-c)
* Android: Kotlin //TODO: add links

> **Important!**  After cloning, make sure to update the client side apps with your server base URL and the mobile key as required.
> Your server base URL is the URL your backend demo application uses. If you deployed to Heroku with the above button, the URL is similar to `YOUR_SERVER_URL.herokuapp.com`

### 2. Run Your Client App

At this point you have a client side application and a backend application to support it.

You can run the client app on two different devices, and log in as the user `Jane` on one device and the user `Joe` on the other.

You are now ready to make and receive calls, and add other advanced voice functionality with Nexmo Voice API.

## Add Voice Functionality

Upon Nexmo application creation, you define an `answer_url` [webhook](/concepts/guides/webhooks) to it. The `answer_url` contains the actions that will execute as soon as a call is places to the Nexmo number assigned to your Nexmo application. Those actions are defined in a JSON the the `answer_url` returns, which follows the structure of a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference).

Updating the NCCO that returns from your `answer_url` changes the call functionality and allows you to add rich capabilities to your contact center application.

The backend demo application already set the `answer_url` endpoint for you. To update the NCCO content and functionality it enables, navigate to  **App Settings** on the top menu, and click **Edit NCCO**.

### Receive a Phone Call

For the primary use case, when a caller calls your contact center application, connect the call to the agent `Jane`, which will receive the call in-app.

Edit the NCCO as such:

```json
[
    {
        "action": "talk",
        "text": "Thank you for calling Jane"
    },
    {
        "action": "connect",
        "endpoint": [
            {
                "type": "app",
                "user": "Jane"
            }
        ]
    }
]
```

#### Save the new NCCO, and try it out!

1. Run your client side app.
2. Log in as `Jane`
3. On another phone device, call the Nexmo number assigned to your Nexmo application.
4. Recieve the call on the client side app.

### Make a Phone Call

To allow a logged in user, for example the agent `Jane`, to call from the app to a phone number, edit the NCCO as such:

```json
[
    {
        "action": "talk",
        "text": "Please wait while we connect you."
    },
    {
        "action": "connect",
        "timeout": 20,
        "endpoint": [
            {
                "type": "phone",
                "number": "CALLEE_PHONE_NUMBER"
            }
        ]
    }
]
```

>**Note:** Make sure to update `CALLEE_PHONE_NUMBER` with the phone number you want to call to.

#### Save the NCCO, and try it out!

If you are already logged in, tap the "Call" button in the client app. A call will be placed from the app to the phone number you stated in the NCCO.

//TODO: add using a phone number dynamically?

### Create an Interactive Voice Response (IVR)

IVR allows you to direct the call according to user's input. For instance, if the caller presses the `1` digit, call is directed to the agent `Jane`. Otherwise, if the caller presses `2` the call is directed to the agent `Joe`.

To implement that, edit the NCCO as such:

```json
[
    {
        "action": "talk",
        "text": "Thank you for calling my contact center."
    },
    {
        "action": "talk",
        "text": "To talk to Jane, please press 1, or, to talk to Joe, press 2."
    },
    {
        "action": "input",
        "eventUrl": ["YOUR_SERVER_URL/webhooks/dtmf"]
    }
]
```

>**Note:** Make sure you updated `YOUR_SERVER_URL` your server base URL.
> If you deployed the demo backend application to Heroku with the button above, look at the URL of the backend application UI. Your server URL is similar to `YOUR_SERVER_URL.herokuapp.com`

In the NCCO, the `input` action collects the digit that the user pressed, and sends it to the indicated `eventUrl`. That `eventUrl` is another `NCCO` that is executed to continue to handle the call, according to the user input. In this case that `eventUrl` is implemented on your behalf by the backend demo application, to connect the call to the respective agent.

Try it out by calling the number associated with the app.

#### Save the new NCCO, and try it out!

1. Run two different instances of your client side app, on two emulators, devices or browser tabs.
2. Log in as `Jane` in one instance, and log in as `Joe` on the other instance.
3. On another phone device, call the Nexmo number assigned to your Nexmo application.
4. On the phone call, press the digit of the agent you want to connect to.
5. Recieve the call on the client app, of the agent you asked to be connected to.

### Call Queue

User call an agent → stream music → connect to agent (according to backend trigger)

try it out.

### Call Whisper

Jane whispers to Joe

try it out.

### Hot Transfer

agent presses a button to transfer the call.

try it out.


## Wrap Up

Congratulations! you have created your first contact center application!

You have:

* Used a backend application that enables user management, authorization, webhooks and more
* Used a client side application, that uses NexmoClient SDK to make and receive in-app calls
* Enabled voice capabilities by updating the NCCO returned by your Nexmo application `answer_url`

## What's Next?

* [Learn more about event flow between the different Nexmo componenets.](/conversation/guides/event-flow)

* [Learn more about the required components when setting up your Conversation API and Client SDK application.](/conversation/guides/application-setup)

* [Add push notification to your mobile app](/client-sdk/setup/set-up-push-notifications)

## Reference

* Explore [Client SDK](/client-sdk/overview)
* Explore [Voice API](/conversation/overview)
* Explore [Conversation API](/conversation/overview)
