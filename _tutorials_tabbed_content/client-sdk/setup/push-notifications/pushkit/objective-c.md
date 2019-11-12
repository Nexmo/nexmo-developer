---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
- (void) registerForVoIPPushes {
    self.voipRegistry = [[PKPushRegistry alloc] initWithQueue:nil];
    self.voipRegistry.delegate = self;
    
    // Initiate registration.
    self.voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}
```
