---
title: Swift
language: swift
menu_weight: 2
---

Using the `call` object received in `client(_:didReceive:)`:

```swift
call.reject { [weak self] error in
    if let error = error {
        print("error declining call: \(error.localizedDescription)")
        // handle call decline failure
        ...
        return
    }
    // handle call decline success
    ...
}
```
