---
title: Call
description: A Call consists of one or more Legs.
navigation_weight: 5
---

# Call

A call consists of one or more [Legs](/conversation/concepts/leg).

For example, consider a call being made from a mobile phone to a Nexmo Number, and you want the call to be forwarded to another phone. This communication requires a [Conversation](/conversation/concepts/conversation) to be created. This Conversation is identified by a unique ID with the form `CON-<uuid>`. Within the Conversation a Leg will be created from the first phone to Nexmo. This Leg is identified by a unique ID. When the call is forwarded, another Leg is created, with its own unique ID, within the existing Conversation. The Call therefore is made up of one Conversation and two Legs in this case.

Calls with a single leg are created when only a single mobile phone and Nexmo number are the only participants in a call. A common use case for this is using the `record` action to [build a voicemail system](/voice/voice-api/code-snippets/record-a-message). When the user dials a Nexmo number, a [Conversation](/conversation/concepts/conversation) is created, and a leg created from the user's phone to Nexmo. When the user hangs up, the call ends. This Call is comprised of one Conversation and one Leg.
