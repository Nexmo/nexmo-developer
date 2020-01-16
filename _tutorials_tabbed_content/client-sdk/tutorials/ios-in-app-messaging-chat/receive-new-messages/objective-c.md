---
title: Objective-C
language: objective_c
menu_weight: 2
---


All events we got so far are already in this conversation. So how do we display any new incoming messages? We can achieve this by implementing the conversation delegate method.

Firstly, inside `getConversation` method, let's add `self` as the delegate for the conversation received:

```objective-c
- (void)getConversation {
    [NXMClient.shared getConversationWithUuid:kConversationUUID completionHandler:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        self.error = error;
        self.conversation = conversation;
        [self updateInterface];
        [conversation setDelegate:self];  // NEW LINE
        [self getEvents];
    }];
}
```

Now, locate the following line `//MARK: Conversation Delegate` towards the end of `ConversationViewController.m` and implement the `NXMConversationDelegate` protocol:

```objective-c
//MARK: Conversation Delegate

- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
- (void)conversation:(NXMConversation *)conversation didReceiveTextEvent:(NXMTextEvent *)event {
    [self.events addObject:event];
    [self updateInterface];
}

```

The first method is mandatory whilst all `conversation:didReceive:` for each event type are optional. We've only implemented the variant for `NXMTextEvent` above.


