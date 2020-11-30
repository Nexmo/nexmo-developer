---
title: Update Conversation
navigation_weight: 5
---

# Update Conversation

In this code snippet you learn how to update a Conversation.

## Example

Ensure the following variables are set to your required values using any convenient method:

```snippet_variables
- CONVERSATION_ID
- CONV_NEW_NAME
- CONV_NEW_DISPLAY_NAME
```

```code_snippets
source: '_examples/conversation/conversation/update-conversation'
application:
  use_existing: |
    You will need to use an existing Application that contains Conversations in order to be able to update one. See the Create Conversation code snippet for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you will update the specified Conversation with a new name and display name.
