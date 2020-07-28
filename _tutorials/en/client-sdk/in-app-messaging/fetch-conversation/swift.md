---
title: Fetch the conversation
description: In this step you join your Users to your Conversation
---

# Fetch the Conversation

You're now ready to fetch the conversation to use for our chat app.

Inside `ConversationViewController.swift`, locate the following line `//MARK: Fetch Conversation` and fill in the `getConversation` method implementation:

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

Notice the use of the `NXMClient.shared` singleton - this references the same object that was a `client` property in `UserSelectionViewController`.

> **Note:** This is where we get to use the `conversationId` static property we've defined in the "The starter project" step.

If a conversation has been retrieved, you're ready to process to the next step: getting the events for your conversation.
