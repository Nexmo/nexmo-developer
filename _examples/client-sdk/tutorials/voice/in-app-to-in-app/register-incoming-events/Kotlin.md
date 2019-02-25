---
title: Kotlin
navigation_weight: 0
---

```java
override fun onStart() {
    super.onStart()
    NexmoClient.get().addIncomingCallListener(incomingCallListener)
}

override fun onStop() {
    NexmoClient.get().removeIncomingCallListeners()
    super.onStop()
}
```
