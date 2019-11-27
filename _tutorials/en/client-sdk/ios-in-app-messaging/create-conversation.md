---
title: Create a conversation
description: In this step you learn how to create a conversation.
---

# Create a conversation

A [Conversation](/conversation/concepts/conversation) is a shared core component that Nexmo APIs rely on. It connects [Users](/conversation/concepts/user) and allows them to communicate.

Use the `NXMClient` to create a new conversation:

```objective-c
[client createConversationWithName:@"conversation name" completion:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        if(error) {
            //Handle error
            return;
        }
    //Do Something with the conversation
}];
```

Note that `"conversation name"` should be *unique* with regards to the scope of your `application_id`. At the end of this Async request, the completion block is invoked with an `NXMConversation` object if the conversation was created, or an error object if something went wrong.

The conversation identifier, is needed to query this conversation at a later time:

```objective-c
NSString* conv_id = conversation.conversationId;
```
