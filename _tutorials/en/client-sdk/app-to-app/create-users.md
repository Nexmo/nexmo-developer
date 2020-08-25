---
title: Create the users
description: In this step you learn how to create the Users that will participate in the In-App Voice Call.
---

# Create the users

Each participant in an [In-App Voice](/client-sdk/in-app-voice/overview) Call is represented by a [User](/conversation/concepts/user) object and must be authenticated by the Client SDK. In a production application, you would typically store this user information in a database.

Execute the following commands to create two users, `Alice` and `Bob` who will log in to the Nexmo Client and participate in the call.

```bash
nexmo user:create name="Alice"
nexmo user:create name="Bob"
```

This will return user IDs similar to the following:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

There is no need to remember this user ID because we will use user names (instead of user IDs) to add them to the voice call.
