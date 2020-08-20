---
title: Java
language: java
---

```java
public class MyFirebaseMessagingService extends FirebaseMessagingService {

    // We can retrieve client instance only if it has been already initialized
    // new NexmoClient.Builder().build(context)
    private NexmoClient client = NexmoClient.get();

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);

        client.enablePushNotifications(token, new NexmoRequestListener<Void>() {
            @Override
            public void onSuccess(@Nullable Void p0) {}

            @Override
            public void onError(@NonNull NexmoApiError nexmoApiError) {}
        });
    }
}
```
