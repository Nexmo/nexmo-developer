---
title: Swift
language: swift
menu_weight: 1
---


All events we got so far are already in this conversation. So how do we display any new incoming messages? We can achieve this by implementing the conversation delegate method.

Firstly, inside `getConversation` method, let's add `self` as the delegate for the conversation received:

```swift
func getConversation() {
    NXMClient.shared.getConversationWithUuid(User.conversationId) { [weak self] (error, conversation) in
        self?.error = error
        self?.conversation = conversation
        self?.updateInterface()
        if conversation != nil {
            self?.getEvents()
        }
        conversation?.delegate = self  // set self as delegate
    }
}
```

Now, locate the following line `//MARK: Conversation Delegate` towards the end of `ConversationViewController.swift` and implement the `NXMConversationDelegate` protocol:

```swift
//MARK: Conversation Delegate

extension ConversationViewController: NXMConversationDelegate {
    func conversation(_ conversation: NXMConversation, didReceive error: Error) {
        NSLog("Conversation error: \(error.localizedDescription)")
    }
    func conversation(_ conversation: NXMConversation, didReceive event: NXMTextEvent) {
        self.events?.append(event)
        DispatchQueue.main.async { [weak self] in
            self?.updateInterface()
        }
    }
}
```

The first method is mandatory whilst all `conversation(_:didReceive:)` for each event type are optional. We've only implemented the variant for `NXMTextEvent` above.

