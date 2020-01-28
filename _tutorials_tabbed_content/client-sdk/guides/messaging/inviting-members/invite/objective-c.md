---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective_c
[conversation inviteMemberWithUsername:@"Jane" completion:^(NSError * _Nullable error) {
    if (error) {
        NSLog(@"Error inviting user: %@", error);
        return;
    }
    NSLog(@"User invited");
}];
```