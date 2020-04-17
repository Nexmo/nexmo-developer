---
title: Kotlin
language: kotlin
---

```kotlin
conversation.sendCustomEvent("my_custom_event", hashMapOf("key" to "data"), object : NexmoRequestListener<Void> {
    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Custom event error")
    }

    override fun onSuccess(p0: Void?) {
        Log.d("TAG", "Custom event sent")
    }
})
```
