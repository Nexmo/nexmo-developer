---
title: Kotlin
language: android
menu_weight: 1
---

```java
var callEventListener = NexmoCallEventListener(...)

nexmoCall?.addCallEventListener(callEventListener)
```

Remove the listener when needed:

```java
nexmoCall?.removeCallEventListener(callEventListener)
```
