---
title: Join a conversation
description: In this step you learn how to join a conversation.
---

# Join a conversation

Join a conversation to be a member of the conversation and have the ability to send and receive messages and other conversation-related information:

```objective-c
[conversation joinWithCompletion:^(NSError * _Nullable error, NXMMember * _Nullable member) {
        if(error) {
            //Handle error
            return;
        }
    //You are now a member of this conversation
}];
```
