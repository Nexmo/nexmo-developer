---
title: Kotlin
navigation_weight: 0
---

```java
val incomingCallListener = NexmoIncomingCallListener { call ->
    currentCall = call
    startActivity(Intent(this@CreateCallActivity, IncomingCallActivity::class.java))
}
```