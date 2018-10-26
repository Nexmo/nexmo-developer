---
title: User
description: A User represents an entity such as a person that wishes to communicate.
---

# User

A User is an object that identifies a unique Nexmo user in the context of a Nexmo Application. Nexmo enables these User instances to communicate with one another. A User typically has a 1-to-1 mapping with a user in your application’s user database.

A User can have multiple Memberships to Conversations and can communicate with other Users through various media such as Messaging, Voice, and Video.

A person who will communicate via a Conversation must first have a User object created. A User can be thought of as an endpoint for communication. When the User object is created it is assigned a unique user ID.
