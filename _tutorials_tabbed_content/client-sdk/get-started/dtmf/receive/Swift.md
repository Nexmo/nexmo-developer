---
title: Swift
language: swift
menu_weight: 2
---

The DTMF events will be received in the implementation of the `dtmfReceived(_, callMember)` optional method for your `NXMCallDelegate`:


```swift
func dtmfReceived(_ dtmf: String, callMember: NXMCallMember) {
  print("DTMF received:`\(dtmf)` from `\(String(describing: callMember.user.name))`")
}
```
