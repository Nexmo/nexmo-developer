---
title: Swift
language: swift
menu_weight: 1
---

```swift
conversation.inviteMember(withUsername: "Jane", completion: { (error) in
    if let error = error {
        NSLog("Error inviting user: \(error.localizedDescription)")
        return
    }
    NSLog("User invited")
})
```
