---
title: Create the user
description: In this step you learn how to create the User that will participate in the Call.
---

# Create the User

Each participant in a [Call](/conversation/concepts/call) is represented by a [User](/conversation/concepts/user) object and must be authenticated by the Client SDK. In a production application, you would typically store this user information in a database.

Execute the following command to create a user `Alice` who will log in to the Nexmo Client and communicate.

```bash
nexmo user:create name="Alice"
```

This will return user IDs similar to the following:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

There is no need to remember this user ID because we will use JWT token to authenticate the user.