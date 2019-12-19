---
title: Swift
language: swift
menu_weight: 1
---


Inside `ConversationViewController.swift`, locate the following line 

`//MARK: Fetch Conversation` 

and fill in the `getConversation` method implementation:

```swift
//MARK: Fetch Conversation

func getConversation() {
    NXMClient.shared.getConversationWithUuid(User.conversationId) { [weak self] (error, conversation) in
        self?.error = error
        self?.conversation = conversation
        self?.updateInterface()
        if conversation != nil {
            self?.getEvents()
        }
    }
}
```

Notice the use of the `NXMClient.shared` singleton - this references the exact same object we had as a `client` property in `UserSelectionViewController`.

> **Note:** This is where we get to use the `conversationId` static property we've defined in the "The Starter Project" step.

If a conversation has been retrieved, we're ready to process to the next step: getting the events for our conversation.