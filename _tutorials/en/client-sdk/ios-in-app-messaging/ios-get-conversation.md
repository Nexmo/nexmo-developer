---
title: Get a conversation
description: In this step you learn how to get a conversation.
---

# Get an existing conversation

Getting an existing conversation using a conversation identifier:

```objective-c
[client getConversationWithId:@"conversation identifier" completion:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        if(error) {
            //Handle error
            return;
        }
    //Do Something with the conversation
}];
```

At the end of this Async request, the completion block is invoked with an `NXMConversation` object if the conversation was created, or an error object if something went wrong.
