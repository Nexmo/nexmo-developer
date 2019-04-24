---
title: Kotlin
language: android
menu_weight: 1
---

```java
val callee = listOf(...)
var callListener = object: NexmoRequestListener<NexmoCall> {...}

NexmoClient.get().call(callees, NexmoCallHandler.IN_APP, callListener);

```
