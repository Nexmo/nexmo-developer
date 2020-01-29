---
title: Kotlin
language: android
menu_weight: 4
---


```kotlin
var customEventListener: NexmoCustomEventListener = NexmoCustomEventListener { event ->
    Log.d(TAG, "Incoming custom event of type " + event.customType + ": " + event.data)
}

conversation.addCustomEventListener(customEventListener)
```
