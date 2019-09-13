---
title: Objective-C
language: objective_c
menu_weight: 2
---

Implement `endCall` method and call hangup for `call`.

```objective-c
- (void)endCall {
    [self.call hangup];
    [self updateInterface];
}
```
