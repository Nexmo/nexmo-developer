---
title: Objective-C
language: objective_c
menu_weight: 2
---

Add a `voipRegistry` property:

```objective_c
@property PKPushRegistry* voipRegistry;
```

and set it up:

```objective_c
- (void) registerForVoIPPushes {
    self.voipRegistry = [[PKPushRegistry alloc] initWithQueue:nil];
    self.voipRegistry.delegate = self;
    
    // Initiate registration.
    self.voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}
```
