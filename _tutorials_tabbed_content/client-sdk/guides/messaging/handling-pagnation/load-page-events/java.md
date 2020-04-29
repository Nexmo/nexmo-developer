---
title: Java
language: java
---

```java
NexmoRequestListener<NexmoEventsPage> conversationEventsListener = new NexmoRequestListener<NexmoEventsPage>() {
    @Override
    public void onSuccess(@Nullable NexmoEventsPage eventsPage) {
        Collection<NexmoEvent> events = eventsPage.getData();
    }

    @Override
    public void onError(@NonNull NexmoApiError apiError) {
        Log.d("TAG", "Error: Unable to load conversation events %s", apiError.getMessage());
    }
};

conversation.getEvents(100, NexmoPageOrder.NexmoMPageOrderAsc, null, conversationEventsListener);
```
