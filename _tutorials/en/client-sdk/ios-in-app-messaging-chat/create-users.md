---
title: Create the users
description: In this step you learn how to create the Users that will participate in the Conversation.
---

# Create the Users

Each participant in a Conversation is represented by a [User](/conversation/concepts/user) object and must be authenticated by the Client SDK. In a production application, you would typically store this user information in a database.

Execute the following commands to create two users, `Jane` and `Joe` who will log in to the Nexmo Client and participate in the chat.

```bash
nexmo user:create name="Jane"
nexmo user:create name="Joe"
```

This will return user IDs similar to the following:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```
