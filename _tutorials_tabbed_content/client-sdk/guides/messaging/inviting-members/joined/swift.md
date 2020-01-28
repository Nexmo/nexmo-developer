---
title: Swift
language: swift
menu_weight: 1
---

Add `NXMConversationDelegate` as an extension to a `ViewController` or similar, and implement `conversation(_ conversation: NXMConversation, didReceive event: NXMMemberEvent)`:

> Note: The first method below is required when implementing `NXMConversationDelegate`:

```swift
extension ViewController: NXMConversationDelegate {
    func conversation(_ conversation: NXMConversation, didReceive error: Error) {
        NSLog("Conversation error: \(error.localizedDescription)")
    }
    func conversation(_ conversation: NXMConversation, didReceive event: NXMMemberEvent) {
        if event.state == .joined {
            NSLog("\(event.member.user.name) joined.")
        }
    }
}
```