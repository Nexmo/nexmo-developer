---
title: Java
language: android
menu_weight: 3
---

```java
List<String> callee = ...;
NexmoRequestListener<NexmoCall> callListener = ...;

NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, callListener);

```
