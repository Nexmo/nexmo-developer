---
title: Overview
---

# In-App Video Overview [Developer Preview]

Nexmo In-App Video uses WebRTC and includes all the essentials you need to build a feature rich video experience.

- User Control – Users can control whether their video stream is muted or unmuted.

- Notifications  – Users can be notified when they receive a video call or when participants are muted.

## Concepts

**Conversation**
    -> A conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and and can have associated Users through Memberships.

**User**
    -> The concept of a user exists in Nexmo APIs, you can associate one with a user in your own application if you choose. A user can have multiple memberships to conversations and can communicate with other users through various different mediums.

**Member**
    -> Memberships connect users with conversations. Each membership has one conversation and one user however a user can have many memberships to conversations just as conversations can have many members.

**Video**
    -> Video streams can be enabled and disabled in a Conversation so that Members can communicate with video.

**Media Events**
    -> Media events will fire in a Conversation when media state changes for a member. This can be when an Video stream is started or ended.

**Member Media Events**
    -> Media events will fire in on a Member when media state changes for a member. This can be when an Video stream is started or ended.


## Try out the quickstarts

* [JavaScript Quickstarts](/stitch/in-app-video/guides/1-enable-video/javascript)

## SDK Documentation

<div class="row">
  <div class="columns small-12 medium-4">
    <a href="/stitch/sdk-documentation/javascript" class="card spacious card--image card--javascript">
      <h2>JavaScript</h2>
    </a>
  </div>
</div>

## References

* [API Reference](/api/stitch)
* [Nexmo CLI](https://github.com/nexmo/nexmo-cli/tree/beta)
* [Server-side API and SDK](https://github.com/Nexmo/stitch-demo) demo

## Find the SDK online

<div class="row">
  <div class="columns small-12 medium-4">
    <a href="https://www.npmjs.com/package/nexmo-stitch" class="card spacious card--image card--javascript-outline">
      <h2>JavaScript</h2>
    </a>
  </div>
</div>
