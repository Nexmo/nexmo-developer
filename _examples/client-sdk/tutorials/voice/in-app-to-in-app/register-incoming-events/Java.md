---
title: Java
navigation_weight: 1
---

```java
@Override
protected void onStart() {
    super.onStart()
    NexmoClient.get().addIncomingCallListener(incomingCallListener);
}

@Override
protected void onStop() {
    NexmoClient.get().removeIncomingCallListeners();
    super.onStop();
}
```