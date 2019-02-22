---
title: Swift
language: swift
menu_weight: 1
---

Go back to the `//MARK: NXMClientDelegate` line and add the `incomingCall:' method

```swift
func incomingCall(_ call: NXMCall) {
    print("📲 📲 📲 Incoming Call: \(call)")
    DispatchQueue.main.async {
        self?.displayIncomingCallAlert(call: call)
    }
}
```
