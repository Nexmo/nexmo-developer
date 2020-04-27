---
title: Java
language: java
---

```java
conversation.sendAttachment(imageFile, new NexmoRequestListener<Void>() {
    public void onSuccess(@Nullable Void p0) {
        Log.d("TAG", "Image sent");
    }

    public void onError(@NotNull NexmoApiError apiError) {
        Log.d("TAG", "Error: Image not sent " + apiError.getMessage());
    }
});
```
