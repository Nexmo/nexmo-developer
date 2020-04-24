---
title: Kotlin
language: kotlin
---

```kotlin
val muteListener = object : NexmoRequestListener<NexmoCallMember> {
    override fun onSuccess(callMember: NexmoCallMember?) {
        Log.d("TAG", "Member muted $callMember")
    }

    override fun onError(apiError: NexmoApiError) {
        Log.d("TAG", "Error: Mute member ${apiError.message}")
    }
}

// Mute member
callMember.mute(true, muteListener)

// Mute my member
call?.myCallMember?.mute(true, muteListener)

// Mute whole call
call?.mute(true)
```
