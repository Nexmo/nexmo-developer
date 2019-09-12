---
title: Swift
language: swift
menu_weight: 1
---

Note the second parameter in the `client?.call` method above - while `NXMCallHandler.inApp` is useful for simple calls, you can also start a call with customized logic [using a NCCO](/client-sdk/in-app-voice/concepts/ncco-guide), by choosing `NXMCallHandler.server` as the `callHandler`.

```swift
client?.call(callee, callHandler: .server) { [weak self] (error, call) in
	...
}
```
