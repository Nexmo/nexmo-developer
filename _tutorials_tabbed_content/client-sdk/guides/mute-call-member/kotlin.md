---
title: Kotlin
language: kotlin
---

```kotlin
val listener = object : NexmoRequestListener<CallMember> {
    override fun onError(nexmoApiError: NexmoApiError) {
            TODO("Handle error")
        }

        override fun onSuccess(callMember: CallMember) {
            TODO("Handle success")
        }
    }

member.mute(ActionStatus.ON, listener)

//Mute my Member
call.mute(ActionStatus.ON, listener)

```
