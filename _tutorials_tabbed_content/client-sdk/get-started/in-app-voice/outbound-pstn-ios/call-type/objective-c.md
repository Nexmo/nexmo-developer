---
title: Objective-C
language: objective_c
menu_weight: 2
---

```objective-c
[self.nexmoClient call:@callee callHandler:NXMCallHandlerInApp completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
	...
}];
```