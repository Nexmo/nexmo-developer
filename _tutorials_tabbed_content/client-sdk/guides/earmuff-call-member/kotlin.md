---
title: Kotlin
language: kotlin
---

```kotlin
val earmuffListener = object : NexmoRequestListener<NexmoCallMember> {
    override fun onSuccess(callMember: NexmoCallMember?) {
        Log.d("TAG", "Member earmuff enabled $callMember")
    }

    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Error: Earmuff member ${apiError.message}")
    }
}

// Earmuff member
call?.callMembers?.firstOrNull()?.earmuff(true, earmuffListener)

// Earmuff my member
call?.myCallMember?.earmuff(true, earmuffListener)
```
