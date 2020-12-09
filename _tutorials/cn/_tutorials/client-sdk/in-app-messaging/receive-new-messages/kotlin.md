---
title:  Receive new messages
description:  In this step you display any new messages

---

Receive new messages
====================

You can display incoming messages by implementing the conversation listener.

Now, locate the `private val messageListener = object : NexmoMessageEventListener` property in the `ChatFragment` class and implement conversation listener `onTextEvent(textEvent: NexmoTextEvent)` method:

```kotlin
private val messageListener = object : NexmoMessageEventListener {
    override fun onTypingEvent(typingEvent: NexmoTypingEvent) {}

    override fun onAttachmentEvent(attachmentEvent: NexmoAttachmentEvent) {}

    override fun onTextEvent(textEvent: NexmoTextEvent) {
        updateConversation(textEvent)
    }

    override fun onSeenReceipt(seenEvent: NexmoSeenEvent) {}

    override fun onEventDeleted(deletedEvent: NexmoDeletedEvent) {}

    override fun onDeliveredReceipt(deliveredEvent: NexmoDeliveredEvent) {}
}
```

Now each time a new message is received `onTextEvent(textEvent: NexmoTextEvent)` listener is called, the new message will be passed to `updateConversation(textEvent: NexmoTextEvent)` method and dispatched to the view via `conversationMessages` `LiveData` (same `LiveData` used to dispatch all the messages after loading conversation events).

The last thing to do is to make sure that all listeners are removed when `ChatViewModel` is destroyed, for example, when the user navigates back. Fill the body of the `onCleared()` method in the `ChatViewModel` class.

```kotlin
override fun onCleared() {
    conversation?.removeMessageEventListener(messageListener)
}
```

