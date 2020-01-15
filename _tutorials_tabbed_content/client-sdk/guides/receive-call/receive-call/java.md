---
title: Java
language: java
menu_weight: 2
---

```java
NexmoIncomingCallListener incomingCallListener = new NexmoIncomingCallListener() {
    @Override
    public void onIncomingCall(NexmoCall call) {
        ...
    }
};

nexmoCall.addIncomingCallListener(incomingCallListener);
```

Remove the listener when needed:

```java
nexmoCall.removeIncomingCallListener(incomingCallListener);

```