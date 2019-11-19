---
title: Swift
language: swift
menu_weight: 1
---

```swift
func registerForVoIPPushes() {
    self.voipRegistry = PKPushRegistry(queue: nil)
    self.voipRegistry.delegate = self
    self.voipRegistry.desiredPushTypes = [PKPushTypeVoIP]
}
```
