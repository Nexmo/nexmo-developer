---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
// delegate must conform to NXMCallDelegate
[client call:@[@"userId"] callType:NXMCallTypeInApp delegate:delegate 
  completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
    if (!call) {
        // Handle create call failure
        return
    }
    // Handle call created successfully. 
    // methods on the `delegate` will be invoked with needed updates
}];

```
