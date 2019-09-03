---
title: Create a custom Event
navigation_weight: 2
---

# Add custom event

Custom events can be used to add metadata to your conversation. There are some restrictions when using custom events:

* Event type must begin with `custom:`
* Event type must not exceed 100 characters
* Event type must contain ONLY alphanumeric, `-` and `_` characters
* Event body must not exceed 4096 bytes

## Example

Ensure the following variables are set to your required values using any convenient method:

Key | Description
-- | --
`CONVERSATION_ID` | The unique ID of the Conversation.
`MEMBER_ID` | The unique ID of the Member.

```code_snippets
source: '_examples/conversation/event/create-custom-event'
application:
  use_existing: |
    You will need to use an existing Application that contains a Conversation in order to be able to add a custom event. See the Create Conversation code snippet for information on how to create an Application and some sample Conversations.
```

## Try it out

When you run the code you'll see a custom event in your [event list](/conversation/code-snippets/event/list-events)
