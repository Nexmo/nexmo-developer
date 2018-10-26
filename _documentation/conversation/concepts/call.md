---
title: Call
description: A Call connects two Users in a Conversation.
---

# Call

A call consists of two or more [Legs](/conversation/concepts/leg).

For example, consider a call being made from a mobile phone to a Nexmo Number, and you want the call to be forwarded to another phone. This communication requires a [Conversation](/conversation/concepts/conversation) to be created. This Conversation is identified by a unique ID with the form `CON-<uuid>`. Within the Conversation a Leg will be created from the first phone to Nexmo. This Leg is identified by a unique ID. When the call is forwarded, another Leg is created, with its own unique ID, within the existing Conversation. The Call therefore is made up of one Conversation and two Legs in this case.
