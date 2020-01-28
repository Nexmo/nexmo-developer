---
title: Swift
language: swift
menu_weight: 1
---

```swift
conversation.leave({ (error) in
    if let error = error {
        NSLog("Error leaving conversation: \(error.localizedDescription)")
        return
    }
    NSLog("Conversation left.")
})
```
