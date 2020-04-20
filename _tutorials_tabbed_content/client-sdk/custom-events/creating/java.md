---
title: Java
language: java
---

```java

HashMap<String, Object> data = new HashMap<>();
data.put("key", "data");

conversation.sendCustomEvent("my_custom_event", data, new NexmoRequestListener<Void>() {
    public void onSuccess(@Nullable Void p0) {
        Log.d("TAG", "Custom event sent");
    }

    public void onError(@NotNull NexmoApiError apiError) {
        Log.d("TAG", "Custom event error");
    }
});
```
