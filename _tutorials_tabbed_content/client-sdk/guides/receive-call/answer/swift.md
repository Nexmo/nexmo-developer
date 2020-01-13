---
title: Swift
language: swift
menu_weight: 2
---

Using the `call` object received in `client(_:didReceive:)`:

```swift
call.answer { [weak self] error in
    if let error = error {
        print("error answering call: \(error.localizedDescription)")
        // handle call answer failure
        ...
        return
    }
    // handle call answer success
    ...
}
```
