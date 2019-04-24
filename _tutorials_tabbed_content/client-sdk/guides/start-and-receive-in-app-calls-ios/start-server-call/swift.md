---
title: Swift
language: swift
menu_weight: 1
---

```swift
// delegate must conform to NXMCallDelegate
client?.call(["userId"], callType: .server, delegate: delegate) { (error, call) in
    guard let call = call else {
        // Handle create call failure
        return
    }
    // Handle call created successfully. 
    // methods on the `delegate` will be invoked with needed updates
})

```
