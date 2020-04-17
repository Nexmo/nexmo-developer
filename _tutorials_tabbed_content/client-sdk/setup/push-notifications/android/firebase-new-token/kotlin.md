---
title: Kotlin
language: kotlin
---

```kotlin
class MyFirebaseMessagingService: FirebaseMessagingService() {
    // No need for client initialization here. Client initialization is already done in BaseApplication class.
    // NexmoClient.Builder().build(this)
    private val client = NexmoClient.get()

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        
        client.enablePushNotifications(token, object: NexmoRequestListener<Void> {
            override fun onSuccess(p0: Void?) { }

            override fun onError(apiError: NexmoApiError) {}
        })
    }
}
```
