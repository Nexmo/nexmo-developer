---
title: Overview
---

# In-App Voice Overview [Developer Preview]

Nexmo In-App Voice uses WebRTC and includes all the essentials you need to build a feature rich voice experience. 

- User Control – Users can control whether their audio stream is muted or unmuted.
- Notifications  – Users can be notified when they receive a call or when participants are muted.
- 1:1 or Group Calls – Configure call settings so users can start a direct or group call by adding participants in real time.

Nexmo In-App Voice also integrates with the Nexmo [Voice API](/voice/voice-api/overview) as an additional channel alongside PSTN phone calls, SIP & WebSocket. The Voice API allows users to build high-quality programmable voice applications and amplifies the In-App Voice offering through extra functionality such as:

- Outbound and inbound call management
- Complex call flow configurations 
- Voice stream recording
- Conference calling 
- Text-to-speech messages in 23 languages 

## Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user however a user can have many memberships to conversations just as conversations can have many members.

**Audio**
    -> Audio streams can be enabled and disabled in a Conversation so that Members can communicate with voice.

**Media Events**
    -> Media events will fire in a Conversation when media state changes for a member. This can be when an Audio stream is started or ended.

## Try out the Quick Start Guides


* [JavaScript Quick Start](/stitch/in-app-voice/guides/enable-audio/javascript)
* [Android Quick Start](/stitch/in-app-voice/guides/enable-audio/android)
* [iOS Quick Start](/stitch/in-app-voice/guides/enable-audio/ios)

