---
title: Kotlin
language: android
menu_weight: 4
---


```kotlin
var sendListener: NexmoRequestListener<Void> = object: NexmoRequestListener<Void> {
    override fun onError(error: NexmoApiError) {
        Log.d(TAG, "Custom event error")
    }
    override fun onSuccess(var1: Void?) {
        Log.d(TAG, "Custom event sent")
    }
}

conversation.sendCustomEvent("my_custom_event", hashMapOf("your" to "data"), sendListener)
```
