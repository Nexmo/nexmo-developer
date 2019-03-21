---
title: Update a User
---

# Update a User

In this code snippet you will see how to update a User's details.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`USER_NEW_NAME` | The new unique name of the User.
`USER_NEW_DISPLAY_NAME` | The new display name of the User.

```code_snippets
source: '_examples/conversation/user/update-user'
application:
  use_existing: |
    You will need to use an existing Application and have a User in order to be able to update a User. See the Create Conversation code snippet for information on how to create an Application. See also the Create User code snippet on how to create a User.
```

## Try it out

When you run the code you will update the name and display name of the specified User.
