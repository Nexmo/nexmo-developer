---
title: Java
language: java
menu_weight: 5
---


```java
private NexmoRequestListener<Void> customEventSendListener =  new NexmoRequestListener<Void>() {
    @Override
    public void onError(NexmoApiError error) {
        Log.d("Custom event", "Error");
    }

    @Override
    public void onSuccess(Void aVoid) {
        Log.d("Custom event", "Success");
    }
};

HashMap<String, Object> customData = new HashMap<>();
customData.put("your", "data");

conversation.sendCustomEvent("my_custom_event_type", customData, customEventSendListener);
```
