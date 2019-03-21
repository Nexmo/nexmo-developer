---
title: List Members
---

# List Members

In this code snippet you will see how to list the Members of a specified Conversation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`CONVERSATION_ID` | The unique ID of the Conversation.

```code_snippets
source: '_examples/conversation/member/list-members'
application:
  use_existing: |
    You will need to use an existing Application that contains a Conversation and at least one Member in order to be able to list Members. See the Create Conversation code snippet for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you will retrieve a lits of all Members of the specified Conversation.
