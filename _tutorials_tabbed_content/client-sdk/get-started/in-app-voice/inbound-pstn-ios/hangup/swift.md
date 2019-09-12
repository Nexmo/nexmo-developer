---
title: Swift
language: swift
menu_weight: 1
---

Once Jane presses the 'End Call' button, it is time to hangup the call. Implement the private `end:` method and call hangup for `myCallMember`.

```swift
private func end(call: NXMCall) {
    guard let call = call else {
        updateInterface()
        return
    }
    call.hangup()
}
```

Updates for `callMember` statuses are received in `call(_:didUpdate:with:)` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation is already handling call hangup.