---
title: Overview
description: This topic provides an overview of how to build in-app voice applications using the Client SDK.
navigation_weight: 0
---

# In-App Voice Overview

The Client SDK makes it straightforward to include IP-based voice communication capabilities in your web (JavaScript), Android, and iOS applications. Use voice within your apps to build [contact center](/use-cases/contact-center-client-sdk), [marketplace](/use-cases/digital-marketplace-client-sdk) and B2C (Business to Consumer) solutions that include:

* [App to app calling](/client-sdk/tutorials/app-to-app/introduction/)
* [Click to call](/use-cases/client-sdk-click-to-call)
* [Audio conferencing](/voice/voice-api/code-snippets/connect-callers-into-a-conference)
* [Automatic speech recognition](/voice/voice-api/guides/asr)
* [Websockets](/voice/voice-api/guides/websockets)
* [Text-to-speech](/voice/voice-api/guides/text-to-speech)

The Client SDK also enables you to include [in-app voice](/client-sdk/in-app-voice/overview) and [in-app messaging](/client-sdk/in-app-messaging/overview) in your applications so that your customers can communicate with you using their preferred channels.

### Features Include
Client SDK In-App Voice uses WebRTC and includes all the essentials you need to build a feature-rich voice experience that includes:

* 1:1 or Group Calls
* Audio Controls – Mute, earmuff
* DTMF Support

### Extendability Through the Voice API
Client SDK In-App Voice is a part of the Vonage Voice API which amplifies the In-App Voice offering by enabling:

* Calls to phones (PSTN)
* Calls to SIP-enabled devices
* Connection to other services over Websockets
* Call management
* Complex call flow configurations
* Voice stream recording
* Conference calling
* Text-to-speech messages in 23 languages

### Native SDK Specific Features
The Android and iOS Client SDKs offer additional capabilities, including:

* Network Change Handling
* Audio Routing Management
* Push Notifications

## Voice calls

**To make a voice call, use the Client SDK `callServer()` method. This enables you to use the [Voice API](/voice/voice-api/overview) to manage the call on the server. The Client SDK application manages the [event flow](/conversation/guides/event-flow) of the conversation in the client.**

## Setup

* [Create your App](/client-sdk/setup/create-your-application)
* [Add SDK to your App](/client-sdk/setup/add-sdk-to-your-app)
* [Set up push notifications](/client-sdk/setup/set-up-push-notifications)
* [Configure data center](/client-sdk/setup/configure-data-center)

## Tutorials

* [App to App call](/client-sdk/tutorials/app-to-app)
* [Make a phone call](/client-sdk/tutorials/app-to-phone)
* [Receive a phone call](/client-sdk/tutorials/phone-to-app)

## Concepts

In-app Voice concepts:

```concept_list
product: client-sdk/in-app-voice
```

## Use Cases

```use_cases
product: client-sdk
```

## Reference

* [Client SDK Reference - Web](/sdk/client-sdk/javascript)
* [Client SDK Reference - iOS](/sdk/client-sdk/ios)
* [Client SDK Reference - Android](/sdk/client-sdk/android)
* [Client SDK Samples - Android](https://github.com/nexmo-community/client-sdk-android-samples)

For more information about managing conversations that include voice calls, see the [Conversation API](/conversation/overview)
