---
title: Java
language: java
---

```java
NexmoClient().get().setConnectionListener { newConnectionStatus, connectionStatusReason ->
    Log.d("TAG", "Connection status changed: " + connectionStatus + " " + connectionStatusReason);
}
```
