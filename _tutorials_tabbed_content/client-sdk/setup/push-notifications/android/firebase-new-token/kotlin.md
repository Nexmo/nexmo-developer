---
title: Kotlin
language: kotlin
---

```kotlin
class MyFirebaseMessagingService: FirebaseMessagingService() {
    
    // We can retrieve client instance only if it has been already initialized
    // NexmoClient.Builder().build(context)
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
