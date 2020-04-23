---
title: Kotlin
language: kotlin
---

```kotlin
conversation?.allMembers?.firstOrNull()?.let {
    conversation.kick(it, object : NexmoRequestListener<Any> {
        override fun onSuccess(p0: Any?) {
            Log.d("TAG", "User kick success")
        }

        override fun onError(apiError: NexmoApiError) {
            Log.d("TAG", "Error: Unable to kick user ${apiError.message}")
        }
    })
}
```
