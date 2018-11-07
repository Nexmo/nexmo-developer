---
title: List a User's Conversations
---

# List a User's Conversations

In this building block you will see how to get a list of Conversations a User is associated with.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`USER_ID` | The unique ID of the User.

```building_blocks
source: '_examples/conversation/user/list-user-conversations'
application:
  use_existing: |
    You will need to use an existing Application containing at least one Conversation and one User in order to see a list of a User's Conversations. See the Create Conversation building block for information on how to create an Application and a Conversation. See also the Create User building block on how to create a User.
```

## Try it out

When you run the code you will get a list of Conversations associated with the specified User.
