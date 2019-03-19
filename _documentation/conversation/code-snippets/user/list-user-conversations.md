---
title: List a User's Conversations
---

# List a User's Conversations

In this Code Snippet you will see how to get a list of Conversations a User is associated with.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`USER_ID` | The unique ID of the User.

```code_snippets
source: '_examples/conversation/user/list-user-conversations'
application:
  use_existing: |
    You will need to use an existing Application containing at least one Conversation and one User in order to see a list of a User's Conversations. See the Create Conversation Code Snippet for information on how to create an Application and a Conversation. See also the Create User Code Snippet on how to create a User.
```

## Try it out

When you run the code you will get a list of Conversations associated with the specified User.

In this case the User is associated with a single Conversation:

``` json
[
  {
    "name": "mega_chat",
    "timestamp": {
      "created": "2018-10-18T13:28:14.760Z"
    },
    "image_url": "",
    "display_name": "Mega Chat Room",
    "state": "JOINED",
    "member_id": "MEM-62667429-e0fa-4adb-87a9-b4768fd46fce",
    "sequence_number": 8,
    "href": "https://api.nexmo.com/beta/users/USR-ebf6ca49-4941-4762-b7a6-c30cb0c06179/conversations/CON-0b72410c-e090-45b2-86b7-65ff0c986c02",
    "id": "CON-0b72410c-e090-45b2-86b7-65ff0c986c02"
  }
]
```