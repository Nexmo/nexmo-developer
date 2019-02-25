---
title: Java
navigation_weight: 1
---


```java
NexmoRequestListener<NexmoCall> callListener = new NexmoRequestListener<NexmoCall>() {
    @Override
    public void onError(NexmoApiError nexmoApiError) { }

    @Override
    public void onSuccess(NexmoCall call) {
        NexmoHelper.currentCall = call;

        Intent intent = new Intent(CreateCallActivity.this, OnCallActivity.class);
        startActivity(intent);
    }
};
```
