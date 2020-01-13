---
title: Kotlin
language: android
menu_weight: 4
---

```java
val callee = "..."
var callListener = object: NexmoRequestListener<NexmoCall> {...}

NexmoClient.get().call(callee, NexmoCallHandler.SERVER, callListener);

```
