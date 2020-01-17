---
title: Kotlin
language: android
menu_weight: 1
---

The DTMF events will be received in your implementation of `NexmoCallEventListener.onDTMF()` method, on the `NexmoCallEventListener` that is attached to the `NexmoCall`.

```java

callEventListener = object : NexmoCallEventListener {
    //…

    override fun onDTMF(dtmf: String, member: NexmoCallMember) {
        TODO("implement DTMF received")
    }
}

currentCall?.addCallEventListener(callEventListener)

```
