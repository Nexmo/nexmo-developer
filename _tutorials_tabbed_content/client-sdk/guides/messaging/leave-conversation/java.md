---
title: Java
language: java
---

```java
if (conversation.getAllMembers().size() > 0) {
    NexmoMember member = conversation.getAllMembers().iterator().next();

    conversation.kick(member, new NexmoRequestListener<Void>() {
        @Override
        public void onSuccess(@Nullable Void aVoid) {
            Log.d("TTAG", "User kick success");
        }

        @Override
        public void onError(@NonNull NexmoApiError apiError) {
            Log.d("TTAG", "Error: Unable to kick user " + apiError.getMessage());
        }
    });
}
```
