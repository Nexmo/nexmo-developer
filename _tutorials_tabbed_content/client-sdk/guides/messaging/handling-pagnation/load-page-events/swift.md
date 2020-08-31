---
title: Swift
language: swift
---

```swift
conversation.getEventsPage(withSize: 10, order: .asc) { (error, page) in
    
    if let error = error {
        print(error)
        return
    }
    
    self.events = page?.events
}
```
