---
title: Create a User
---

# Create a User

In this building block you will see how to create a User.

## Example

You can create a user by defining the following variables as part of the request:

Key | Description
-- | --
`USER_NAME` | The unique name of the User.
`USER_DISPLAY_NAME` | The display name of the User.

Typically, you can utilise the `USER_NAME` as a means to map your Nexmo User to your own system's users.
If that is not passed in the request, we will generate and populate the field with a unique ID.
The `USER_DISPLAY_NAME` can be used for your UI.

You can enrich the user object by populating even more parameters like channel details(ex. phone number) and image_url to point to a thumbnail. You can find those in the API Ref[https://developer.nexmo.com/api/conversation#createUser] though in general, no parameters are required in the request's payload in order to create your users.
If no 


```building_blocks
source: '_examples/conversation/user/create-user'
application:
  use_existing: |
    You will need to use an existing Application in order to be able to create a User. See the Create Conversation building block for information on how to create an Application.
```

## Try it out

When you run the code you will create a new User.
