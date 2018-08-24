---
title: Legs and Conversations
description: When a phone call is made or received by Nexmo it is added to a conversation. A single conversation contains one or more phone calls (sometimes referred to as legs).
navigation_weight: 2
---

# Legs and Conversations

## Overview

The Nexmo Voice API has two concepts associated with a call - a leg and a conversation.

A leg refers to a single connection either inbound to, or outbound from, the Nexmo platform.

A conversation contains one or more call legs. Each [endpoint](/voice/voice-api/guides/endpoints) connected to a conversation is its own leg.

When a new inbound or outbound phone call is received, a new conversation is created and the leg for the phone call is created. Once this has happened, an NCCO is retrieved from your `answer_url` and executed within the context of the conversation.

Additional legs may be added to the conversation using the `connect` action. If an NCCO contains multiple `connect` actions, then each new participant will be joined into the same conversation and all parties will be able to hear each other.

Legs and conversations are each identified by their own UUID. Conversation UUID's are prefixed with `CON-`.

## Conferences

You can create a special type of conversation by using the `conversation` action within an NCCO. This resulting named conversation then acts like a conference bridge. New legs can then be added to this conversation by executing a `conversation` action with the same name.

Conversation names are scoped to an application level. This means that any legs that are connected to a conversation with the same name will be able to hear each other, provided they are using the same Nexmo Application.
