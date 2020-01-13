---
title: Java
language: java
menu_weight: 1
---

```java
List<String> callee = ...;
NexmoRequestListener<NexmoCall> callListener = ...;

NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, callListener);

```
