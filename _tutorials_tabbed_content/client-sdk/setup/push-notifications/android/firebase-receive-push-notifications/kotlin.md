---
title: Kotlin
language: kotlin
---

```kotlin
class MyFirebaseMessagingService : FirebaseMessagingService() {

    // We can retrieve client instance only if it has been already initialized
    // in Application class or Activity:
    // NexmoClient.Builder().build(context)
    private val client = NexmoClient.get()

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        //...   
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        // determine if the message is sent from Nexmo server
        if (NexmoClient.isNexmoPushNotification(remoteMessage.data)) {
            client.processNexmoPush(remoteMessage.data, object : NexmoPushEventListener {
                override fun onIncomingCall(call: NexmoCall?) {
                    Log.d("TAG", "FirebaseMessage:onIncomingCall() with: $call")
                }

                override fun onNewEvent(event: NexmoEvent?) {
                    Log.d("TAG", "FirebaseMessage:onNewEvent() with: $event")
                }

                override fun onError(apiError: NexmoApiError?) {
                    Log.d("TAG", "FirebaseMessage:onError() with: $apiError")
                }
            })
        }
    }
}
```
