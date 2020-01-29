---
title: Objective-C
language: objective_c
menu_weight: 2
---

Implement `conversation:didReceiveCustomEvent:`:, part of the `NXMConversationDelegate` protocol:

```objective_c
- (void)conversation:(NXMConversation *)conversation didReceiveCustomEvent:(NXMCustomEvent *)event {
    NSLog(@"Received custom event with type %@: %@", event.customType, event.data);
}
```