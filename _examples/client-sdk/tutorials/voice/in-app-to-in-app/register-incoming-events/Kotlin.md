---
title: Kotlin
navigation_weight: 0
---

```Kotlin
override fun onStart() {
    super.onStart()
    NexmoClient.get().addIncomingCallListener(incomingCallListener)
}

override fun onStop() {
    NexmoClient.get().removeIncomingCallListeners()
    super.onStop()
}

```