---
title:  Fetch conversation events
description:  In this step you display any messages already sent as part of this Conversation

---

Fetch conversation events
=========================

Right below  `getConversation()` method, let's add a method to retrieve the events:

```kotlin
private fun getConversationEvents(conversation: NexmoConversation) {
    conversation.getEvents(100, NexmoPageOrder.NexmoMPageOrderAsc, null,
        object : NexmoRequestListener<NexmoEventsPage> {
            override fun onSuccess(nexmoEventsPage: NexmoEventsPage?) {
                nexmoEventsPage?.pageResponse?.data?.let {
                    _conversationMessages.postValue(it.toList())
                }
            }

            override fun onError(apiError: NexmoApiError) {
                _errorMessage.postValue("Error: Unable to load conversation events ${apiError.message}")
            }
        })
}
```

Once the events are retrieved (or an error is returned), we're updating the view (`ChatFragment`) to reflect the new data.

> **NOTE:** We are using two `LiveData` streams. `_conversationMessages` to post successful API response and `_errorMessage` to post returned error.

Let's make our view react to the new data. Inside `ChatFragment` locate the `private var conversationMessages = Observer<List<NexmoEvent>?>` property and add this code to handle our conversation history:

```kotlin
private var conversationMessages = Observer<List<NexmoEvent>?> { events ->
    val messages = events?.mapNotNull {
        when (it) {
            is NexmoMemberEvent -> getConversationLine(it)
            is NexmoTextEvent -> getConversationLine(it)
            else -> null
        }
    }

    conversationMessagesTextView.text = if (messages.isNullOrEmpty()) {
        "Conversation has No messages"
    } else {
        messages.joinToString(separator = "\n")
    }

    progressBar.isVisible = false
    chatContainer.isVisible = true
}
```

To handle member related events (member invited, joined or left) we need to fill the body of the `fun getConversationLine(memberEvent: NexmoMemberEvent)` method:

```kotlin
private fun getConversationLine(memberEvent: NexmoMemberEvent): String {
    val user = memberEvent.member.user.name

    return when (memberEvent.state) {
        NexmoMemberState.JOINED -> "$user joined"
        NexmoMemberState.INVITED -> "$user invited"
        NexmoMemberState.LEFT -> "$user left"
        else -> "Error: Unknown member event state"
    }
}
```

Above method converts `NexmoMemberEvent` to a `String` that will be displayed as a single line in the chat conversation. Similar conversion need to be done for `NexmoTextEvent`. Let's fill the body of the `getConversationLine(textEvent: NexmoTextEvent)` method:

```kotlin
private fun getConversationLine(textEvent: NexmoTextEvent): String {
    val user = textEvent.fromMember.user.name
    return "$user said: ${textEvent.text}"
}
```

> **NOTE:** In this tutorial, we are only handling member-related events `NexmoMemberEvent` and `NexmoTextEvent`. Other kinds of events are being ignored in the above `when` expression (`else -> null`).

Now we are ready to send the first message.

