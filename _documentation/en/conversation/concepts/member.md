---
title: Member
description: A Member is created when a User joins a Conversation.
navigation_weight: 4
---

# Member

In order for a User to communicate through a [Conversation](/conversation/concepts/conversation) they must join the Conversation through a membership.

Member objects connect Users with Conversations. When a User joins a Conversation, a Member object has to be created. Each Member object has one Conversation and one User associated with it.

A Member object has one associated Channel, so one User can have many Member objects associated with it, according to the Channels that they can be reached through.

A User can be associated with many Member objects in Conversations, just as a Conversation can have many Members.

A Member can have one of several states such as `invited`, `joined` and `left`.

Each Member has a unique Member ID of the form:

```
MEM-df8e57d8-1c8e-4573-bf4d-29d5414dcb42
```

Memberships can be created in various ways: [via the Conversation API](/conversation/code-snippets/member/create-member), using the functions provided by the [Client SDK](/client-sdk/overview), or using the command line.

> **NOTE:** There is a limit of 100 Members that can be added to a Conversation.
