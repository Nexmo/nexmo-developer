---
title: Overview
---

# In-App Video Overview [Developer Preview]

Nexmo In-App Video uses WebRTC and includes all the essentials you need to build a feature rich video experience:

- User Control – Users can control whether their video stream is muted or unmuted.

- Notifications  – Users can be notified when they receive a video call or when participants are muted.

## Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user, however, a user can have many memberships to conversations just as conversations can have many members.

**Video**
    -> Video streams can be enabled and disabled in a Conversation so that Members can communicate with video.

**Media Events**
    -> Media events will fire in a Conversation when media state changes for a member. This can be when a Video stream is started or ended.

**Member Media Events**
    -> Media events will fire in on a Member when media state changes for a member. This can be when a Video stream is started or ended.


## Try out the JavaScript Quick Start Guides

* [Enable Video](/stitch/in-app-video/guides/enable-video/javascript)
* [Enable Screen Sharing](/stitch/in-app-video/guides/enable-screenshare/javascript)
