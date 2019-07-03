---
title: Application
description: A Nexmo Application provides a container for Users and Conversations.
navigation_weight: 1
---

# Application

Once you have created a Nexmo Account you will be able to create multiple Nexmo Applications. Each Nexmo Application is identified by a unique Application ID.

A Nexmo Application can contain a unique set of [Users](/conversation/concepts/user) and [Conversations](/conversation/concepts/conversation).

This container hierarchy is illustrated in the following diagram:

![Nexmo Application](/assets/images/conversation-api/conversation-application.png)

Notice that the set of Conversations and Users is unique to the Application, so there can be no conflicts.

A Conversation API call such as List Conversations would have a URL such as:

```
https://api.nexmo.com/beta/conversations
```

So which Conversations would be retrieved?

The answer lies in the fact that each API call is authenticated using a JWT, and the JWT contains the Application ID of a specific Nexmo Application. The Conversations returned would be those associated with the Application ID specified in the JWT.

Note that as a JWT is signed using the private key of the specific nexmo Application, the Conversation API is always authenticated to a specific Application. It is therefore not possible to use the Conversation API to look at the Conversations of an Application you do not have the private key for.
