---
title: Kotlin
language: android
menu_weight: 1
---

```java
val incomingCallListener = NexmoIncomingCallListener { call ->
    currentCall = call
    startActivity(Intent(this@MainActivity, IncomingCallActivity::class.java))
}

NexmoClient.get().addIncomingCallListener(incomingCallListener)

```

Remove the listener when needed:

```java
NexmoClient.get().removeIncomingCallListeners()

```
