---
title: Java
language: java
---

```java
conversation.sendText(message, new NexmoRequestListener<Void>() {
    public void onSuccess(@Nullable Void p0) {
        Log.d("TAG", "Message sent");
    }

    public void onError(@NotNull NexmoApiError apiError) {
        Log.d("TAG", "Error: Message not sent " + apiError.getMessage());
    }
});
```
