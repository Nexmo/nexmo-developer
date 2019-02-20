---
title: Kotlin
navigation_weight: 0
---

```Kotlin
var callListener = object : NexmoRequestListener<NexmoCall> {
    override fun onError(nexmoApiError: NexmoApiError) {
        notifyError(nexmoApiError)
    }

    override fun onSuccess(call: NexmoCall) {
        currentCall = call

        val intent = Intent(this@CreateCallActivity, OnCallActivity::class.java)
        startActivity(intent)
    }
}
```