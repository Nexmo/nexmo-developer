---
title: Java
language: java
menu_weight: 5
---


```java
private NexmoCustomEventListener customEventListener = new NexmoCustomEventListener() {
    @Override
    public void onCustomEvent(NexmoCustomEvent event) {
        Log.d("Custom event", "Incoming custom event of type " + event.getCustomType() + ": " + event.getData());
    }
};

conversation.addCustomEventListener(customEventListener);
```
