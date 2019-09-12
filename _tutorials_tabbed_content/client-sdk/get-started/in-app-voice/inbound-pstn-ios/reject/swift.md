---
title: Swift
language: swift
menu_weight: 1
---

Under the `//MARK: Incoming call - Reject`, implement this method to reject the incoming call:

```swift
private func reject(call: NXMCall) {
    call.reject { [weak self] error in
        if let error = error {
            print("error declining call: \(error.localizedDescription)")
        }
        self?.updateInterface()
    }
}
```
