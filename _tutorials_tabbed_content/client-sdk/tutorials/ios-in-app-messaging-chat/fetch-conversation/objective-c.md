---
title: Objective-C
language: objective_c
menu_weight: 2
---


Inside `ConversationViewController`, locate the following line 

`//MARK: Fetch Conversation` 

and fill in the `getConversation` method implementation:

```objective-c
//MARK: Fetch Conversation

- (void)getConversation {
    [NXMClient.shared getConversationWithUuid:kConversationUUID completionHandler:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        self.error = error;
        self.conversation = conversation;
        [self updateInterface];
        [self getEvents];
    }];
}
```

Notice the use of the `NXMClient.shared` singleton - this references the exact same object we had as a `client` property in `UserSelectionViewController`.

> **Note:** This is where we get to use the `kConversationUUID` static property we've defined in the "The Starter Project" step.

If a conversation has been retrieved, we're ready to process to the next step: getting the events for our conversation.

