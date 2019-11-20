---
title: Channel
description: A Channel refers to one of App, Phone, SIP or Websocket.
navigation_weight: 6
---

# Channel

A Channel is a communication mechanism. A User's available Channels determine how they can send and receive communications.

The Channels supported are:

1. App
2. Phone
3. SIP
4. Websocket

Examples:

1. A User uses an App (Channel) to send in-app messages (Media) in a chat.
2. A User uses a Phone (Channel) to receive Voice calls (Media) on his phone device.

It is then possible to mix Channels so that you can create:

1. An App (Channel) makes a Voice (Media) call to a mobile Phone (Channel).
2. A Phone (Channel) makes a Voice (Media) call to a Websocket (Channel).

The following table shows how each Channel supports each Media:

| Channel | In-app Messaging | In-app Voice | PSTN | SIP | Websocket | In-app Video |
| ----| :----: | :----: | :----: | :----: | :----: | :----: |
| App | ✅ | ✅ |   | | | ✅|
| Phone |  |  | ✅ | | | |
| SIP |  |  |  | ✅ |  | |
| Websocket |  |  |  | | ✅ | |

You can send a type of [Media](/conversation/concepts/media) through a Channel. Some Channels (such as App, can support multiple media types, for example In-app Messaging, In-app Voice and In-app Video). 

The relationship between Media and Channels is illustrated in the following diagram:

![Channels and Media](/assets/images/conversation-api/channels-media.png)
