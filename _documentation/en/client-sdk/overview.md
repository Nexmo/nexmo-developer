---
title: Overview
meta_title: Realtime communication with In-App Messaging and In-app Voice
description: This topic provides a brief overview of Nexmo Client SDK.
---

# Overview

Nexmo Client SDK allows you to build Programmable Conversation applications.

Using the Conversation API and the Client SDK you can build complete applications that feature two-way voice and messaging communications. Whereas the [Conversation API](/conversation/overview) can be used directly to build out the backend of your Programmable Conversation application, the Client SDK enables you to quickly and easily build the client-side application. The backend usually deals with tasks such as managing users in a database, the generation of tokens for those users, and the creation of the [Conversations](/conversation/concepts/conversation). The client-side provides methods to log users into Nexmo, and handle the various [Events](/conversation/concepts/event) that are generated as communication takes place. Other client-side functions include generating member invites if required, displaying typing indicators, and handling voice call operations such as inbound call, making a call, a user hanging up, and so on.

Client SDK enables communications across multiple [Channels](/conversation/concepts/channel) including:

* Voice
* SIP
* Websockets
* App

The following media types are supported:

* Messaging
* Voice

The Client SDK supports the following platforms and languages:

Platform | Language
----|----
Web | JavaScript
iOS (10.2 and above) | Objective-C, Swift
Android (6.0 and above - API level 23 and above) | Java, Kotlin

## In-App Messaging

The Client SDK enables you to build a feature-rich chat experience that includes typing indicators and sent, delivered and read receipts.

Some features include:

* Offline Sync – With built-in caching, messages are saved and sent or received once their device is back online.
* Push Notifications – Keep users aware of important alerts by sending notifications to their device.
* Text and Image Support – Users can quickly send and receive texts and images from your application.

Read more about:

* [In-App Messaging](/client-sdk/in-app-messaging/overview)

## In-App Voice

The Client SDK enables you to build in-app voice features into your application. Nexmo In-App Voice uses WebRTC and includes all the essentials you need to build a feature-rich voice experience.

Some features include:

* User Control – Users can control whether their audio stream is muted or unmuted.
* Notifications  – Users can be notified when they receive a call or when participants are muted.
* Group Calls – Configure call settings so users can start a group call by adding participants in real time.

Read more about:

* [In-App Voice](/client-sdk/in-app-voice/overview)

## Concepts

Many of the concepts used in the Client SDK are a result of the design of the [Conversation API](/conversation/overview), which is the underlying technology. The following Concepts will help you use the Client SDK:

```concept_list
product: conversation
```

## SDK Documentation (generated from source code)

<div class="Vlt-grid">
  <div class="Vlt-col Vlt-col--center">
    <a href="/sdk/client-sdk/javascript/" class="Vlt-btn Vlt-btn--tertiary Vlt-btn--large">
      <svg class="Vlt-yellow"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-js"></use></svg>
      JavaScript
    </a>
  </div>
  <div class="Vlt-col Vlt-col--center">
    <a href="/sdk/client-sdk/android/" class="Vlt-btn Vlt-btn--tertiary Vlt-btn--large">
      <svg class="Vlt-green-light"><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-android"></use></svg>
      Android
    </a>
  </div>
  <div class="Vlt-col Vlt-col--center">
    <a href="/sdk/client-sdk/ios/" class="Vlt-btn Vlt-btn--tertiary Vlt-btn--large">
      <svg><use xlink:href="/symbol/volta-icons.svg#Vlt-icon-apple"></use></svg>
      iOS
    </a>
  </div>
</div>

## References

* [Conversation API](/conversation/overview)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli/tree/beta)
* [Node.JS and Angular Demo](https://github.com/Nexmo/stitch-demo) with an [Android](https://github.com/Nexmo/stitch-demo-android) client demo
* [Tutorials](/client-sdk/tutorials)
* [Use Cases](/client-sdk/use-cases)
