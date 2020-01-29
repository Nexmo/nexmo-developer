---
title: Swift
language: swift
menu_weight: 1
---

Implement `conversation(_ conversation: NXMConversation, didReceive event: NXMCustomEvent)`, part of the `NXMConversationDelegate` protocol:

```swift
func conversation(_ conversation: NXMConversation, didReceive event: NXMCustomEvent) {
    NSLog("Received custom event with type \(String(describing: event.customType)): \(String(describing: event.data))");
}
```
