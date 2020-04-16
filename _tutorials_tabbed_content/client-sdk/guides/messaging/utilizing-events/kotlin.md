---
title: Kotlin
language: kotlin
---

```kotlin
private fun getConversationEvents(conversation: NexmoConversation) {
    conversation.getEvents(100, NexmoPageOrder.NexmoMPageOrderAsc, null,
        object : NexmoRequestListener<NexmoEventsPage> {
            override fun onSuccess(nexmoEventsPage: NexmoEventsPage?) {
                nexmoEventsPage?.pageResponse?.data?.let {
                    processEvents(it.toList())
                }
            }

            override fun onError(apiError: NexmoApiError) {
                Log.d("TAG", "Error: Unable to load conversation events ${apiError.message}")
            }
        })
}

private fun processEvents(events: List<NexmoEvent>) {
    events.forEach {
        val message = when (it) {
            is NexmoMemberEvent -> getEventText(it)
            is NexmoTextEvent -> getEventText(it)
            is NexmoSeenEvent -> getEventText(it)
            is NexmoDeliveredEvent -> getEventText(it)
            is NexmoTypingEvent -> getEventText(it)
            else -> "Unsupported event ${it.eventType}"
        }

        Log.d("TAG", message)
    }
}

private fun getEventText(typingEvent: NexmoTypingEvent): String {
    val user = typingEvent.fromMember.user.name
    val typingState = if (typingEvent.state == NexmoTypingState.ON) "typing" else "not typing"
    return "$user is $typingState"
}

private fun getEventText(deliveredEvent: NexmoDeliveredEvent): String {
    val user = deliveredEvent.fromMember.user.name
    return "Event from $user with id ${deliveredEvent.initialEventId()} delivered at ${deliveredEvent.creationDate}"
}

private fun getEventText(seenEvent: NexmoSeenEvent): String {
    val user = seenEvent.fromMember.user.name
    return "$user saw event with id ${seenEvent.initialEventId()} at ${seenEvent.creationDate}"
}

private fun getEventText(textEvent: NexmoTextEvent): String {
    val user = textEvent.fromMember.user.name
    return "$user said: ${textEvent.text}"
}

private fun getEventText(memberEvent: NexmoMemberEvent): String {
    val user = memberEvent.member.user.name

    return when (memberEvent.state) {
        NexmoMemberState.JOINED -> "$user joined"
        NexmoMemberState.INVITED -> "$user invited"
        NexmoMemberState.LEFT -> "$user left"
        else -> "Error: Unknown member event state"
    }
}
```
