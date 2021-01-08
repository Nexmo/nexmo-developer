---
title: Create the users
description: In this step you learn how to create the Users that will participate in the Call.
---

# Create the Users

Each participant is represented by a [User](/conversation/concepts/user) object and must be authenticated by the Client SDK. In a production application, you would typically store this user information in a database.

Execute the following commands in the terminal to create two users, `Alice` and `Bob` who will log in to the Vonage Client and communicate.

```bash
nexmo user:create name="Alice"
nexmo user:create name="Bob"
```

This will return user IDs similar to the following:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You do not need to make a note of these user IDs because we will use [JWTs](/concepts/guides/authentication#jwts) to authenticate users.
