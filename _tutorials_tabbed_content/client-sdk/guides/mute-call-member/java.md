---
title: Java
language: java
---

```java
NexmoRequestListener<NexmoCallMember> muteListener = new NexmoRequestListener<NexmoCallMember>() {
    @Override
    public void onSuccess(NexmoCallMember callMember) {
        Timber.d("Member muted " + callMember);
    }

    @Override
    public void onError(NexmoApiError apiError) {
        Timber.d("Error: Mute member " + apiError.getMessage());
    }
};

// Mute member
callMember.mute(true, muteListener);

// Mute my member
call.getMyCallMember().mute(true, muteListener);

// Mute whole call
call.mute(true);
```
