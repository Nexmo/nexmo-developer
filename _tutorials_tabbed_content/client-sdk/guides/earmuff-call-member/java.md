---
title: Java
language: java
---

```java
 NexmoRequestListener<NexmoCallMember> earmuffListener = new NexmoRequestListener<NexmoCallMember>() {
    @Override
    public void onSuccess(NexmoCallMember callMember) {
        Log.d("TAG", "Member earmuff " + callMember);
    }

    @Override
    public void onError(NexmoApiError apiError) {
        Log.d("TAG", "Error: Earmuff member " + apiError.getMessage());
    }
};

// Earmuff member
NexmoCallMember callMember = call.getCallMembers().iterator().next();
callMember.earmuff(true, earmuffListener);

// Earmuff my member
call.getMyCallMember().earmuff(true, earmuffListener);
```
