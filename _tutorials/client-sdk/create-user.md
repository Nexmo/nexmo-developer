---
title: Create a User
description: In this step you learn how to create a Client SDK User.
---

# Create a User

Create a User who will log in to the Nexmo Client and participate in the SDK functionality such as Conversations, Calls and so on.

Replace `MY_USER_NAME` with a user name, and run the following command:

```bash
nexmo user:create name="MY_USER_NAME"
```

The output is similar to:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

The user ID is used to perform tasks by the Client SDK, such as login, starting a call and more.

The user will be authenticated via a JWT.
