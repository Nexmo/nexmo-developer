---
title: Objective-C
language: objective_c
menu_weight: 2
---

Have a `ViewController`, or similar, conform to `NXMClientDelegate` and implement `client:didReceiveConversation:`:

> Note: The first 2 methods below are required when implementing `NXMClientDelegate`:

```objective_c
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    ...
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    NSLog(@"✆  ‼️ connection error: %@", [error localizedDescription]);
    ...
}

- (void)client:(NXMClient *)client didReceiveConversation:(NXMConversation *)conversation {
    [conversation join:^(NSError * _Nullable error, NXMMember * _Nullable member) {
        if (error) {
            NSLog(@"Error joining conversation: %@", error.localizedDescription);
            return;
        }
        NSLog(@"Conversation joined.");
    }];
}
```