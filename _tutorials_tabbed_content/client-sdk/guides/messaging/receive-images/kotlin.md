---
title: Kotlin
language: kotlin
---

```kotlin
private val messageListener = object : NexmoMessageEventListener {
    override fun onTypingEvent(typingEvent: NexmoTypingEvent) {}

    override fun onAttachmentEvent(attachmentEvent: NexmoAttachmentEvent) {
        val userName = attachmentEvent.fromMember.user.name

        Log.d("TAG", "Image event received. User $userName")

        // Event contains URL's for multiple sizes of images
        attachmentEvent.original.url
        attachmentEvent.medium.url
        attachmentEvent.thumbnail.url

        //Download the image using one of open-source libraries: Coil, Picasso, Glide, etc.
    }

    override fun onTextEvent(textEvent: NexmoTextEvent) {}

    override fun onSeenReceipt(seenEvent: NexmoSeenEvent) {}

    override fun onEventDeleted(deletedEvent: NexmoDeletedEvent) {}

    override fun onDeliveredReceipt(deliveredEvent: NexmoDeliveredEvent) {}
}

conversation?.addMessageEventListener(messageListener)
```
