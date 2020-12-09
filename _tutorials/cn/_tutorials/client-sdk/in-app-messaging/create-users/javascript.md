---
title:  Create the users
description:  In this step you learn how to create the Users that will participate in the Conversation.

---

Create the Users
================

Each participant in a [Conversation](/conversation/concepts/conversation) is represented by a [User](/conversation/concepts/user) object and must be authenticated by the Client SDK. In a production application, you would typically store this user information in a database.

Execute the following commands to create two users, `USER1_NAME` and `USER2_NAME` who will log in to the Vonage Client and participate in the chat (Conversation).

```bash
nexmo user:create name="USER1_NAME"
nexmo user:create name="USER2_NAME"
```

This will return user IDs similar to the following:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

There is no need to remember this user ID because we will use user names (instead of user IDs) to add them to the conversation.

