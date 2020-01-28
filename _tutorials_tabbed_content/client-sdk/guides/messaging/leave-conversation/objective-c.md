---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
[self.conversation leave:^(NSError * _Nullable error) {
    if (error) {
        NSLog(@"Error leaving conversation: %@", error);
        return;
    }
    NSLog(@"Conversation left.");
}]
```