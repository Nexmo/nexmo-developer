---
title: Kotlin
language: kotlin
---

```kotlin
private val messageListener = object : NexmoMessageEventListener {
    override fun onTypingEvent(typingEvent: NexmoTypingEvent) {}

    override fun onAttachmentEvent(attachmentEvent: NexmoAttachmentEvent) {}

    override fun onTextEvent(textEvent: NexmoTextEvent) {}

    override fun onSeenReceipt(seenEvent: NexmoSeenEvent) {
        val userName = seenEvent.fromMember.user.name

        Log.d("TAG", "Event ${seenEvent.initialEventId()} seen by User $userName")
    }

    override fun onEventDeleted(deletedEvent: NexmoDeletedEvent) {}

    override fun onDeliveredReceipt(deliveredEvent: NexmoDeliveredEvent) {}
}

conversation.addMessageEventListener(messageListener)
```
