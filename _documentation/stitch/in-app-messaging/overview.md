---
title: Overview
---

# In-App Messaging Overview [Developer Preview]

Nexmo In-App Messaging enables you to build conversation features where communication can take place across multiple platforms.

The context of the conversations is maintained through each communication event taking place within a conversation, no matter the medium.

> ### In-App Messaging is in developer preview
>
> Currently In-App Messaging offers basic IP messaging with the following features:
>
> * Conversation creation and management
> * Sending and receiving text
> * Member invite management
> * Cache support
> * Typing indicators
> * Message sent, delivered and read receipts
> * Image support
> * Push notifications

## Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user, however, a user can have many memberships to conversations just as conversations can have many members.

## Try out the Quick Start Guides

* [JavaScript Quick Start](/stitch/in-app-messaging/guides/simple-conversation/javascript)
* [Android Quick Start](/stitch/in-app-messaging/guides/simple-conversation/android)
* [iOS Quick Start](/stitch/in-app-messaging/guides/simple-conversation/ios)

