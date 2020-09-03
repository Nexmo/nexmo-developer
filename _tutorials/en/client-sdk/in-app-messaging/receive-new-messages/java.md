---
title: Receive new messages
description: In this step you display any new messages
---

# Receive new messages

You can display incoming messages by implementing the conversation listener.


Now, locate the `private val messageListener = object : NexmoMessageEventListener` property in the `ChatFragment` class and implement conversation listener `onTextEvent(textEvent: NexmoTextEvent)` method:

```java
private NexmoMessageEventListener messageListener = new NexmoMessageEventListener() {
    @Override
    public void onTextEvent(@NonNull NexmoTextEvent textEvent) {
        updateConversation(textEvent);
    }

    @Override
    public void onAttachmentEvent(@NonNull NexmoAttachmentEvent attachmentEvent) {

    }

    @Override
    public void onEventDeleted(@NonNull NexmoDeletedEvent deletedEvent) {

    }

    @Override
    public void onSeenReceipt(@NonNull NexmoSeenEvent seenEvent) {

    }

    @Override
    public void onDeliveredReceipt(@NonNull NexmoDeliveredEvent deliveredEvent) {

    }

    @Override
    public void onTypingEvent(@NonNull NexmoTypingEvent typingEvent) {

    }
};
```

Now each time a new message is received `onTextEvent(textEvent: NexmoTextEvent)` listener is called, the new message will be passed to `updateConversation(textEvent: NexmoTextEvent)` method and dispatched to the view via `conversationMessages` `LiveData` (same `LiveData` used to dispatch all the messages after loading conversation events).

The last thing to do is to make sure that all listeners are removed when `ChatViewModel` is destroyed, for example, when the user navigates back. Fill the body of the `onCleared()` method in the `ChatViewModel` class.

```java
@Override
protected void onCleared() {
    conversation.removeMessageEventListener(messageListener);
}
```
