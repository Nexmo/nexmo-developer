---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
// delegate must conform to NXMCallDelegate
[call answer:delegate completionHandler:^(NSError * _Nullable error) {
    if (error) {
        // Handle answer call failure
    } else {
        // Handle answer call success
    }
}];

```
