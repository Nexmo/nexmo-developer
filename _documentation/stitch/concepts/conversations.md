---
title: Conversations
description: Introduction to the concept of Conversations in Stitch.
navigation_weight: 3
---

# Conversations

A Conversation is a shared core component that Nexmo APIs rely on. Conversations happen over multiple mediums and can have associated Users through Memberships.

The Conversation is key to understanding Stitch. In order for Users to communicate, they must connect to a Conversation, at which point they become Members of that Conversation. A Conversation is capable of supporting text messaging, audio calls, or video calls (which includes audio). For text messaging a Conversation can be thought of as like a chat room. Users can be invited to join a Conversation and they can leave a Conversation. Users can also join multiple Conversations.

## Creating a Conversation

Conversations can be created via the REST API, using one of the SDKs, or on the command line.

To create a Conversation via the command line:

``` shell
$ nexmo conversation:create display_name="Nexmo Chat"
```

This returns a unique ID for the Conversation:

```
CON-35663e9d-687f-4e5c-bd37-91837294bd76
```

## Add a user to a Conversation

To add a User into a Conversation using the command line:

``` shell
$ nexmo member:add YOUR_CONVERSATION_ID action=join channel='{"type":"app"}' user_id=YOUR_USER_ID
```

> Users can also be added using the REST API or via one of the SDKs.

## List Users associated with a Conversation

You can also list Users associated with a Conversation via the command line:

``` shell
$ nexmo member:list CON-35663e9d-687f-4e5c-bd37-91837294bd76 -v
```

Returns something similar to:

``` shell
name  | user_id                                  | user_name | state  
----------------------------------------------------------------------
bob  | USR-fa1acfbb-0087-4fa5-911d-045586470edc | bob      | JOINED
alice | USR-cf0e4ff6-fd86-4d4a-9a90-282a59593480 | alice     | INVITED
```

## Getting a list of Conversations

You can use the REST API to get a list of Conversations:

``` shell
$ curl "https://api.nexmo.com/beta/conversations" \
     -H 'Authorization: Bearer eyJ0eXAiOiJKV1Q....VpwfOz2KGyJ14oL6gqCPfX24Mg' \
     -H 'Content-Type: application/json'
```
