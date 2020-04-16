---
title: Kotlin
language: kotlin
---

```kotlin
NexmoClient().get().setConnectionListener { connectionStatus, connectionStatusReason ->
    Log.d("TAG", "Connection status changed: $connectionStatus $connectionStatusReason")
}
```
