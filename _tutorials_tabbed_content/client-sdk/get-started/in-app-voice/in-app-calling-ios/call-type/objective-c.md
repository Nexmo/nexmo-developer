---
title: Objective-C
language: objective_c
menu_weight: 2
---

Note the second parameter in the `client?.call` method above - while `NXMCallHandlerInApp` is useful for simple calls, you can also start a call with customized logic [using a NCCO](/client-sdk/in-app-voice/concepts/ncco-guide), by choosing `NXMCallHandlerServer` as the `callHandler`.

```objective-c
[self.nexmoClient call:callee callHandler:NXMCallHandlerServer completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
	...
}];
```