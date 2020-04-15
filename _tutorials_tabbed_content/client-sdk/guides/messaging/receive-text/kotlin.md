---
title: Kotlin
language: kotlin
---

```kotlin
private val messageListener = object : NexmoMessageEventListener {
    override fun onTypingEvent(typingEvent: NexmoTypingEvent) {}

    override fun onAttachmentEvent(attachmentEvent: NexmoAttachmentEvent) {}

    override fun onTextEvent(textEvent: NexmoTextEvent) {
        val userName = textEvent.fromMember.user.name
        val text = textEvent.text

        Log.d("TAG", "Message received. User $userName : $text")
    }

    override fun onSeenReceipt(seenEvent: NexmoSeenEvent) {}

    override fun onEventDeleted(deletedEvent: NexmoDeletedEvent) {}

    override fun onDeliveredReceipt(deliveredEvent: NexmoDeliveredEvent) {}
}

conversation?.addMessageEventListener(messageListener)
```
