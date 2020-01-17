---
title: Objective-C
language: objective_c
menu_weight: 3
---

Using the `call` object received in `client:didReceiveCall:`:

```objective_c
[call answer:^(NSError * _Nullable error) {
    if (error) {
        NSLog(@"error answering call: %@", error.localizedDescription);
        // handle call answer failure
        ...
        return;
    }
    // handle call answer success
    ...
}];
```
