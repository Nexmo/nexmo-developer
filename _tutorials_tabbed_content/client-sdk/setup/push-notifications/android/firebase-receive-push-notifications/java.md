---
title: Java
language: java
---

```java
public class MyFirebaseMessagingService extends FirebaseMessagingService {

    // We can retrieve client instance only if it has been already initialized
    // in Application class or Activity:
    // new NexmoClient.Builder().build(context)
    private NexmoClient client = NexmoClient.get();

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);

        //...
    }

    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);

        // determine if the message is sent from Nexmo server
        if (NexmoClient.isNexmoPushNotification(remoteMessage.getData())) {
            client.processNexmoPush(remoteMessage.getData(), new NexmoPushEventListener() {
                @Override
                public void onIncomingCall(NexmoCall call) {
                    Log.d("TAG", "FirebaseMessage:onIncomingCall() with: " + call);
                }

                @Override
                public void onNewEvent(NexmoEvent event) {
                    Log.d("TAG", "FirebaseMessage:onNewEvent() with: " + event);
                }

                @Override
                public void onError(NexmoApiError apiError) {
                    Log.d("TAG", "FirebaseMessage:onError() with: " + apiError);
                }
            });
        }
    }
}
```
