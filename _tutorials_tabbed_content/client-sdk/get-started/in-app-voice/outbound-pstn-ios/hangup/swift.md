---
title: Swift
language: swift
menu_weight: 1
---

Implement the private `end:` method and call hangup for `myCallMember`.

```swift
private func end(call: NXMCall) {
    call.hangup()
}
```

Updates for `callMember` statuses are received in `call(_:didUpdate:with:)` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation is already handling call hangup.
