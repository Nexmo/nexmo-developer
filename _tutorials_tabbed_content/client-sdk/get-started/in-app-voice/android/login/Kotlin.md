---
title: Kotlin
navigation_weight: 0
---

```java
fun loginToSdk(token: String) {
        NexmoClient.get().login(token, object : NexmoRequestListener<NexmoUser> {

            override fun onError(nexmoApiError: NexmoApiError) {
                notifyError(nexmoApiError)
            }

            override fun onSuccess(user: NexmoUser?) {
                currentUser = user

                val intent = Intent(baseContext, MainActivity::class.java)
                startActivity(intent)
                finish()
            }
        })
    }
}
```
