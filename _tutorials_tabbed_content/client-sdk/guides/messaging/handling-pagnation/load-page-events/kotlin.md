---
title: Kotlin
language: kotlin
---

```kotlin
val conversationEventsListener = object : NexmoRequestListener<NexmoEventsPage> {
    override fun onSuccess(nexmoEventsPage: NexmoEventsPage?) {
        nexmoEventsPage?.pageResponse?.data?.let {
            val events = nexmoEventsPage?.data
        }
    }

    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Error: Unable to load conversation events ${apiError.message}")
    }
}

conversation?.getEvents(100, NexmoPageOrder.NexmoMPageOrderAsc, null, conversationEventsListener)
```
