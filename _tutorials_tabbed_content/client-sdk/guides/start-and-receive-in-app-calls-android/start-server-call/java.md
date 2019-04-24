---
title: Java
language: android
menu_weight: 2
---

```java
List<String> callee = ...;
NexmoRequestListener<NexmoCall> callListener = ...;

NexmoClient.get().call(callee, NexmoCallHandler.SERVER, callListener);

```
