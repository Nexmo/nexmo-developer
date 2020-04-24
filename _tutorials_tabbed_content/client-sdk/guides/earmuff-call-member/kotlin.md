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

member.earmuff(ActionStatus.ON, listener)

//Earmuff my Member
call.earmuff(ActionStatus.ON, listener)

```
