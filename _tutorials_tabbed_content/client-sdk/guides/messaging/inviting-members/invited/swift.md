---
title: Swift
language: swift
menu_weight: 1
---

Add `NXMClientDelegate` as an extension to a `ViewController` or similar, and implement `client(_ client: NXMClient, didReceive conversation: NXMConversation)`:

> Note: The first 2 methods below are required when implementing `NXMClientDelegate`:

```swift
extension ViewController: NXMClientDelegate {
    
    func client(_ client: NXMClient, didChange status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        ...
    }
    
    func client(_ client: NXMClient, didReceiveError error: Error) {
        print("✆  ‼️ connection error: \(error.localizedDescription)")
        ...
    }

    func client(_ client: NXMClient, didReceive conversation: NXMConversation) {
        conversation.join { (error, member) in
            if let error = error {
                NSLog("Error joining conversation: \(error.localizedDescription)")
                return
            }
            NSLog("Conversation joined.")
        }
    }
}
```
