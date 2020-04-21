---
title: Kotlin
language: kotlin
---

```kotlin
class MyFirebaseMessagingService : FirebaseMessagingService() {

    // We can retrieve client instance after it has been initializated.
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
