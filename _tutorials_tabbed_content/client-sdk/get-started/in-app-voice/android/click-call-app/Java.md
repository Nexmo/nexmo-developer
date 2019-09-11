---
title: Java
navigation_weight: 1
---

```java
public void onInAppCallClick(View view) {
    String callee = getOtherUserId();
    NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, callListener);
}

String getOtherUserId() {
    return NexmoHelper.user.getName().equals(NexmoHelper.USER_NAME_JANE) ? NexmoHelper.USER_ID_JOE : NexmoHelper.USER_ID_JANE;
}
```
