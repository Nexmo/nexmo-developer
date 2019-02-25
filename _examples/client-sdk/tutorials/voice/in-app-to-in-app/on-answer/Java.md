---
title: Java
navigation_weight: 1
---


```java
public void onAnswer(View view) {
    NexmoHelper.currentCall.answer(new NexmoRequestListener<NexmoCall>() {
        @Override
        public void onError(NexmoApiError nexmoApiError) { }

        @Override
        public void onSuccess(NexmoCall call) {
            startActivity(new Intent(IncomingCallActivity.this, OnCallActivity.class));
            finish();
        }
    });
}
```
