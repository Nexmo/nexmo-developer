---
title: Kotlin
navigation_weight: 0
---

```Kotlin
fun onInAppCallClick(view: View) {
        val callee = listOf(otherUserName)
        NexmoClient.get().call(callee, NexmoCallHandler.IN_APP, callListener)
}

val otherUserName: String
    get() = if (user?.name == USER_NAME_JANE) USER_NAME_JOE else USER_NAME_JANE

```