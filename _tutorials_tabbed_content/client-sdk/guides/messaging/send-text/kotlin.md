---
title: Kotlin
language: kotlin
menu_weight: 2
---

```kotlin
conversation.sendText(message, object : NexmoRequestListener<Void> {
    override fun onSuccess(p0: Void?) {
        Log.d("TAG", "Message has been sent")
    }

    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Error: Message not sent ${apiError.message}")
    }
})
```
