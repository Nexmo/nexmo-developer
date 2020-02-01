---
title: Swift
language: swift
menu_weight: 1
---

Add a `voipRegistry` property:

```swift
var voipRegistry = PKPushRegistry(queue: nil)
```

and set it up:

```swift
func registerForVoIPPushes() {
    self.voipRegistry.delegate = self
    self.voipRegistry.desiredPushTypes = [PKPushType.voIP]
}
```
