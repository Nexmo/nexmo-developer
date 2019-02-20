---
title: Kotlin
navigation_weight: 0
---

```Kotlin
fun loginToSdk(token: String) {
        NexmoClient.get().login(token, object : NexmoRequestListener<NexmoUser> {

            override fun onError(nexmoApiError: NexmoApiError) {
                notifyError(nexmoApiError)
            }

            override fun onSuccess(user: NexmoUser) {
                currentUser = user

                val intent = Intent(baseContext, CreateCallActivity::class.java)
                startActivity(intent)
                finish()
            }
        })
    }
}
```