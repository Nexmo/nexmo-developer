---
title: Kotlin
navigation_weight: 0
---

```Kotlin
val incomingCallListener = NexmoIncomingCallListener { call ->
    currentCall = call
    startActivity(Intent(this@CreateCallActivity, IncomingCallActivity::class.java))
}
```