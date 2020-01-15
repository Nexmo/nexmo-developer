---
title: Java
language: android
menu_weight: 2
---

```java
NexmoCallEventListener callEventListener = ... ;

nexmoCall.addCallEventListener(callEventListener);
```

Remove the listener when needed:

```java
nexmoCall.removeCallEventListener(callEventListener);
```
