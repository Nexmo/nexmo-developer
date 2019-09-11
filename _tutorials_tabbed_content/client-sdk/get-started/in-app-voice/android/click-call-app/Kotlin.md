---
title: Kotlin
navigation_weight: 0
---

```java
fun onInAppCallClick(view: View) {
        val callee = otherUserName
        NexmoClient.get().call(otherUserName, NexmoCallHandler.IN_APP, callListener)
}

val otherUserName: String
    get() = if (user?.name == USER_NAME_JANE) USER_NAME_JOE else USER_NAME_JANE
```
