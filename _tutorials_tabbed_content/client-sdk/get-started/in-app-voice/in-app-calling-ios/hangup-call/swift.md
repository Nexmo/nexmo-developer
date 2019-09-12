---
title: Swift
language: swift
menu_weight: 1
---

Once Jane or Joe presses the 'End Call' button, it is time to hangup the call. Implement the private `end:` method and call hangup for `call`.

```swift
private func end(call: NXMCall) {
    call.hangup()
    callStatus = .completed
    self.call = nil
    updateInterface()
}
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation for `call(_:didUpdate:with:)` is already handling call hangup.