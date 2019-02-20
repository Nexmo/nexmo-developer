---
title: Java
navigation_weight: 1
---

```java
NexmoIncomingCallListener incomingCallListener = new NexmoIncomingCallListener() {
        @Override
        public void onIncomingCall(NexmoCall call) {

            NexmoHelper.currentCall = call;
            startActivity(new Intent(CreateCallActivity.this, IncomingCallActivity.class));
        }
    };
```
