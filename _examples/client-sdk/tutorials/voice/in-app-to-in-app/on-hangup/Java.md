---
title: Java
navigation_weight: 1
---

```java
public void onHangup(View view) {
    NexmoHelper.currentCall.hangup(new NexmoRequestListener<NexmoCall>() {
        @Override
        public void onError(NexmoApiError nexmoApiError) { }

        @Override
        public void onSuccess(NexmoCall call) {
            finish();
        }
    });
}
```
