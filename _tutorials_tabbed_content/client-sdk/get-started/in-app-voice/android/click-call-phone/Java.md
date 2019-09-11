---
title: Java
navigation_weight: 1
---

```java
public void onPhoneCallClick(View view) {
    String callee = CALLEE_PHONE_NUMBER; //TODO: swap with your phone number
    NexmoClient.get().call(callee, NexmoCallHandler.SERVER, callListener);
}
```
