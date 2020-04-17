---
title: Java
language: java
---

```java
public class MyFirebaseMessagingService extends FirebaseMessagingService {

    // No need for client initialization here. Client initialization is already done in BaseApplication class.
    // new NexmoClient.Builder().build(this);
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
