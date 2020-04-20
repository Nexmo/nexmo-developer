---
title: Kotlin
language: kotlin
menu_weight: 4
---


```kotlin
val customEventListener = NexmoCustomEventListener {
    Log.d("TAG", "Incoming custom event of type ${ it.customType} : ${it.data}")
}

conversation.addCustomEventListener(customEventListener)
```
