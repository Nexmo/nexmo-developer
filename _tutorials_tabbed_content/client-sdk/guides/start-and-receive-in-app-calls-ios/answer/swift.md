---
title: Swift
language: swift
menu_weight: 1
---

```swift
// delegate must conform to NXMCallDelegate
call.answer(delegate) { error in
    if let error = error {
        // Handle answer call failure
    } else {
        // Handle answer call success
    }
}

```
