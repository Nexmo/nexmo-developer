---
title: Objective-C
language: objective_c
menu_weight: 2
---

Go back to the `#pragma mark NXMClientDelegate` line and add the `incomingCall:' method

```objective-c
- (void)incomingCall:(nonnull NXMCall *)call {
    self.ongoingCall = call;
    [self displayIncomingCallAlert];
}
```
