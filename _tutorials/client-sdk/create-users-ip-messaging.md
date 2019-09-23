---
title: Create the users
description: In this step you learn how to create the Users that will participate in the Conversation.
---

# Create a User

Create the two Users, `USER1_NAME` and `USER2_NAME` who will log in to the Nexmo Client and participate in the chat.

Execute the following commands, replacing `USER1_NAME` and `USER2_NAME` with suitable user names:

```bash
nexmo user:create name="MY_USER1_NAME"
nexmo user:create name="MY_USER2_NAME"
```

The output for each of the above commands is similar to:

```sh
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

Make a note of each user's ID. You will need these IDs to authenticate your users (using [JWTs](/concepts/guides/authentication#json-web-tokens-jwt)) and add them to the Conversation as Members.
