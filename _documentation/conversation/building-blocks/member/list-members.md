---
title: List Members
---

# List Members

In this building block you will see how to list the Members of a specified Conversation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`CONVERSATION_ID` | The unique ID of the Conversation.

```building_blocks
source: '_examples/conversation/member/list-members'
application:
  use_existing: |
    You will need to use an existing Application that contains a Conversation and at least one Member in order to be able to list Members. See the Create Conversation building block for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you will retrieve a lits of all Members of the specified Conversation.
