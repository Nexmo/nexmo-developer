---
title: User
description: A User represents an entity such as a person that wishes to communicate.
navigation_weight: 2
---

# User

A User is an object that identifies a unique Nexmo user in the context of a Nexmo Application. Nexmo enables these User instances to communicate with one another. A User typically has a 1-to-1 mapping with a user in your application’s user database.

A person who will communicate via a Conversation must first have a User object created. A User can be thought of as an endpoint for communication. When the User object is created it is assigned a unique user ID.

A User is added to a Conversation through a Member object. A User can be a Member in multiple Conversations. A User can also have multiple Member objects in a single Conversation, each Member having a Channel associated with it. For example a User may connect to a Conversation through an App, Voice and SMS where those Channels are available to the User.