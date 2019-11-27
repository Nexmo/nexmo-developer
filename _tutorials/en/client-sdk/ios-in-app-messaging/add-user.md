---
title: Add a user
description: In this step you learn how to add a user to a conversation.
---

# Add a user to a conversation

Add other users as members of this conversation for them to send and receive messages:

```objective-c
[conversation addMemberWithUserId:@"user id" completion:^(NSError * _Nullable error, NXMMember * _Nullable member) {
        if(error) {
            //Handle error
            return;
        }
    //user was added to this conversation
}];
```
