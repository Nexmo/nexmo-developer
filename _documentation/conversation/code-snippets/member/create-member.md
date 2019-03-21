---
title: Create a Member
---

# Create a Member

In this code snippet you will see how to create a Member. A Member can be thought of as a User who has been invited to, joined, or left a Conversation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`CONVERSATION_ID` | The unique ID of the Conversation.
`USER_ID` | The unique ID of the User.

```code_snippets
source: '_examples/conversation/member/create-member'
application:
  use_existing: |
    You will need to use an existing Application that contains a Conversation in order to be able to create a Member. See the Create Conversation code snippet for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you will create a new Member. The specified User will be invited to join the specified Conversation.
