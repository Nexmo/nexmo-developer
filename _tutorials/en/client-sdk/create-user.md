---
title: Create a User
description: In this step you learn how to create a Client SDK User.
---

# Create a User

[Users](/conversation/concepts/user) are a key concept when working with the Nexmo Client SDKs. When a user authenticates with the Client SDK, the credentials provided identify them as a specific user. Each authenticated user will typically correspond to a single user in your users database.

To create a user, run the following command using the Nexmo CLI (which you installed in a previous step), replacing `MY_USER_NAME` with the name that you'd like to use.

```bash
nexmo user:create name="MY_USER_NAME"
```

This will return a user ID similar to the following:

```bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```
