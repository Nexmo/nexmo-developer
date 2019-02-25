---
title: Kotlin
navigation_weight: 0
---

```java
fun onAnswer(view: View) {
    currentCall?.answer(object : NexmoRequestListener<NexmoCall> {
        override fun onError(nexmoApiError: NexmoApiError) {}

        override fun onSuccess(call: NexmoCall) {
            startActivity(Intent(this@IncomingCallActivity, OnCallActivity::class.java))
            finish()
        }
    })
}
```
