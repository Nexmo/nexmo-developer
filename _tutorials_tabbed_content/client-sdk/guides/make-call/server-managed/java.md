---
title: Java
language: java
menu_weight: 5
---

```java
String callee = ...;
NexmoRequestListener<NexmoCall> callListener = ...;

NexmoClient.get().call(callee, NexmoCallHandler.SERVER, callListener);
```
