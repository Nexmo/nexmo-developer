---
title: Kotlin
language: kotlin
---

```kotlin
conversation.sendAttachment(imageFile, object : NexmoRequestListener<Void> {
    override fun onSuccess(p0: Void?) {
        Log.d("TAG", "Image sent")
    }

    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Error: Image not sent ${apiError.message}")
    }
})
```
