---
title: Update Conversation
---

# Update Conversation

In this code snippet you will see how to update a Conversation.

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`CONVERSATION_ID` | Unique ID of the Conversation.
`CONV_NEW_NAME` | The new name.
`CONV_NEW_DISPLAY_NAME` | The new display name.

```code_snippets
source: '_examples/conversation/conversation/update-conversation'
application:
  use_existing: |
    You will need to use an existing Application that contains Conversations in order to be able to update one. See the Create Conversation code snippet for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you will update the specified Conversation with a new name and display name.
